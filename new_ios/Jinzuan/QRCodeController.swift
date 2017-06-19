//
//  QRCodeController.swift
//  Jinzuan
//
//  Created by Brain Liao on 2016/4/13.
//  Copyright © 2016年 Jinzuan. All rights reserved.
//

import UIKit
import AVFoundation

class QRCodeController: ViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    /** 物件資料 */
    var objCaptureSession:AVCaptureSession?
    /** 鏡頭抓到的畫面 */
    var objCaptureVideoPreviewLayer:AVCaptureVideoPreviewLayer?
    /** Alert監聽物件*/
    var commonAlertViewDelegate:CommonAlertViewDelegate!
    /* QRCode Layout*/
    var QrView:QRCodeLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.QrView = QRCodeLayout(frame: self.view.frame,navigationBarFrame: self.navigationController?.navigationBar.frame,uiNavigationItem: self.navigationItem)
        self.view.addSubview(self.QrView)
        self.QrView.loadView()
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            //YES
            self.configureVideoCapture()
            self.addVideoPreviewLayer()
            self.initializeQRView()
        }
        else {
            //NO
            //無法幫使用者打開相機，只能擋住不讓他使用QRCODE
            let alertController = DOAlertController(title: "提示", message: "請至手機本身的「設置」 > 「一般」> 「取用限制」> 「相機」 , 確認您的設定內容", preferredStyle: .Alert)
            let okAction = DOAlertAction(title: "確定", style: .Default, handler: { action in
                
                self.navigationController?.popToRootViewControllerAnimated(true)
            })
            alertController.addAction(okAction)
            // Show alert
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        
    }
    
    func backView()
    {
        
        self.navigationController?.popViewControllerAnimated(true)
    }

    
    /** init Vedio Capture*/
    func configureVideoCapture() {
        
        let objCaptureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        
        do {
            let objCaptureDeviceInput: AnyObject! = try AVCaptureDeviceInput(device: objCaptureDevice) as AVCaptureDeviceInput
            
            objCaptureSession = AVCaptureSession()
            objCaptureSession?.addInput(objCaptureDeviceInput as! AVCaptureInput)
            let objCaptureMetadataOutput = AVCaptureMetadataOutput()
            objCaptureSession?.addOutput(objCaptureMetadataOutput)
            objCaptureMetadataOutput.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
            objCaptureMetadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
        }
        catch {
            
            
            
            let alertController = DOAlertController(title: "提示", message: "請至手機本身的「設置」 > 「隱私」> 「相機」 , 確認您的設定內容", preferredStyle: .Alert)
            let okAction = DOAlertAction(title: "確定", style: .Default, handler: { action in
                
                self.navigationController?.popToRootViewControllerAnimated(true)
            })
            alertController.addAction(okAction)
            // Show alert
            self.presentViewController(alertController, animated: true, completion: nil)
            return
        }
    }
    
    /** add Vedio view */
    func addVideoPreviewLayer() {
        objCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: objCaptureSession)
        objCaptureVideoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        objCaptureVideoPreviewLayer?.frame = self.QrView.contentView.frame
        self.view.layer.addSublayer(objCaptureVideoPreviewLayer!)
        objCaptureSession?.startRunning()
        self.view.bringSubviewToFront(self.QrView.lblQRCodeLabel)
        self.view.bringSubviewToFront(self.QrView.titleView!)
        
        self.QrView?.back_btn.addTarget(self,action:"backView", forControlEvents: .TouchUpInside)
    }
    
    /** init show view */
    func initializeQRView() {
        self.QrView.QRCodeFrameView = UIView()
        self.QrView.QRCodeFrameView!.frame = self.QrView.contentView.frame
        self.QrView.QRCodeFrameView?.layer.borderColor = UIColor.greenColor().CGColor
        self.QrView.QRCodeFrameView?.layer.borderWidth = 5
        self.view.addSubview(self.QrView.QRCodeFrameView!)
        self.view.bringSubviewToFront(self.QrView.QRCodeFrameView!)
        self.view.bringSubviewToFront(self.QrView.lblQRCodeLabel)
        self.view.bringSubviewToFront(self.QrView.titleView!)

    }
    
    /** Vedio Capture delegate */
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        if metadataObjects == nil || metadataObjects.count == 0 {
            self.QrView.QRCodeFrameView?.frame = self.QrView.contentView.frame
            return
        }
        
        let objMetadataMachineReadableCodeObject = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        if objMetadataMachineReadableCodeObject.type == AVMetadataObjectTypeQRCode {
            let objBarCode = objCaptureVideoPreviewLayer?.transformedMetadataObjectForMetadataObject(objMetadataMachineReadableCodeObject as AVMetadataMachineReadableCodeObject) as! AVMetadataMachineReadableCodeObject
            self.QrView.QRCodeFrameView?.frame = objBarCode.bounds;
            self.QrView.QRCodeFrameView?.layer.borderColor = UIColor.redColor().CGColor
            if objMetadataMachineReadableCodeObject.stringValue != nil {
                
                let getString:String = objMetadataMachineReadableCodeObject.stringValue
                
                if !getString.isEmpty {
                        if (getString.indexOf("http") != -1 ){
                            
                            let alertController = DOAlertController(title: "Scan Result", message: getString, preferredStyle: .Alert)
                            let cancelAction = DOAlertAction(title: "Cancel", style: .Cancel, handler: { action in
                                self.QrView.QRCodeFrameView?.frame = self.QrView.contentView.frame
                                self.QrView.QRCodeFrameView?.layer.borderColor = UIColor.greenColor().CGColor
                                self.objCaptureSession?.startRunning()
                            })
                            let okAction = DOAlertAction(title: "Confirm", style: .Default, handler: { action in
                            })
                            alertController.addAction(cancelAction)
                            alertController.addAction(okAction)
                            
                            // Show alert
                            self.presentViewController(alertController, animated: true, completion: nil)
                            
                        }else{
                            
                            let alertController = DOAlertController(title: "讀取結果", message: "此類型的行動條碼無法讀取。", preferredStyle: .Alert)
                            let okAction = DOAlertAction(title: "確定", style: .Default, handler: { action in
                                self.QrView.QRCodeFrameView?.frame = self.QrView.contentView.frame
                                self.QrView.QRCodeFrameView?.layer.borderColor = UIColor.greenColor().CGColor
                                self.objCaptureSession?.startRunning()
                            })
                            alertController.addAction(okAction)
                            
                            // Show alert
                            self.presentViewController(alertController, animated: true, completion: nil)
                        }
                }
            }
        }
    }
    
    /** alert view close delegate */
    func alertView(alertView: UIAlertView, didDismissWithButtonIndex buttonIndex: Int) {
    
    }
    
}

