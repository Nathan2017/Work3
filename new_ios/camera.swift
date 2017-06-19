//
//  camera.swift
//  Nathan
//
//  Created by 冠贏GWIN on 2017/3/7.
//  Copyright © 2017年 Nathan. All rights reserved.
//

import UIKit
import AVFoundation

class camera: UIViewController {
    
    var imageOutput : AVCaptureStillImageOutput?   // TODO
    var bounds = UIScreen.mainScreen().bounds
    
    var session: AVCaptureSession?
    let bar:UINavigationBar = {
        let bar = UINavigationBar()
        bar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        bar.barTintColor = UIColor.blackColor()
        bar.translucent = false
        bar.translatesAutoresizingMaskIntoConstraints = false
        return bar
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        // init camera device
        let captureDevice : AVCaptureDevice? = initCaptureDevice()
        // Prepare output
        let myFirstButton = UIButton(type: .System) as UIButton
        let navitem = UINavigationItem(title: "照片拍摄")
        
        let back = UIBarButtonItem(title: "< Back", style: .Bordered, target: self, action: #selector(goback))
        navitem.leftBarButtonItem = back
        bar.setItems([navitem], animated: false)
        view.addSubview(bar)
        bar.topAnchor.constraintEqualToAnchor(view.topAnchor).active = true
        bar.leftAnchor.constraintEqualToAnchor(view.leftAnchor).active = true
        bar.rightAnchor.constraintEqualToAnchor(view.rightAnchor).active = true
        bar.heightAnchor.constraintEqualToConstant(80).active = true
        
        myFirstButton.setTitle("<< 点此拍照 >>", forState: .Normal)
        myFirstButton.setTitleColor(UIColor.redColor(), forState: .Normal)
        myFirstButton.backgroundColor=UIColor.greenColor()
        myFirstButton.layer.cornerRadius = 6.0
        myFirstButton.layer.masksToBounds = true
        myFirstButton.frame = CGRectMake(60, self.view.frame.size.height - 50, self.view.frame.size.width - 120,30)
        myFirstButton.addTarget(self, action: #selector(takePhoto), forControlEvents: .TouchUpInside)
        initOutput()
        self.view.addSubview(myFirstButton)
        
        if (captureDevice != nil) {
            let deviceInput : AVCaptureInput? = initInputDevice(captureDevice!)
            if (deviceInput != nil) {
                initSession(deviceInput!)
                // Prepare preview  size?
                let previewLayer: AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.session)
                previewLayer.frame = self.view.bounds
                self.view.layer.addSublayer(previewLayer)
                self.session?.startRunning()
                
                
                
            }
        }
        else {
            print("Missing Camera")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillLayoutSubviews() {
        // layout button etc...
    }
    
    
    private func initCaptureDevice() -> AVCaptureDevice? {
        var captureDevice: AVCaptureDevice?
        let devices: NSArray = AVCaptureDevice.devices()
        
        // Get Backcamera
        for device: AnyObject in devices {
            if device.position == AVCaptureDevicePosition.Back {
                captureDevice = device as? AVCaptureDevice
            }
        }
        return captureDevice
    }
    
    
    private func initInputDevice(captureDevice : AVCaptureDevice) -> AVCaptureInput? {
        var deviceInput : AVCaptureInput?
        do {
            deviceInput = try AVCaptureDeviceInput(device: captureDevice)
        }
        catch _ {
            deviceInput = nil
        }
        return deviceInput
    }
    
    private func initOutput() {
        self.imageOutput = AVCaptureStillImageOutput()
    }
    
    private func initSession(deviceInput: AVCaptureInput) {
        
        self.session = AVCaptureSession()
        self.session?.sessionPreset = AVCaptureSessionPresetPhoto
        self.session?.addInput(deviceInput)
        self.session?.addOutput(self.imageOutput!)
        
        // session preset
        
    }
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    func goback(){
        /*var gg = NewViewController()
        
        let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appdelegate.window!.rootViewController = gg*/
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    /*
     *  Take Photo Helper
     */
    
    func takePhoto(sender: UIButton!) {
        let videoConnection : AVCaptureConnection? = self.imageOutput?.connectionWithMediaType(AVMediaTypeVideo)
        if (videoConnection != nil) {
            self.imageOutput?.captureStillImageAsynchronouslyFromConnection(videoConnection, completionHandler: { (imageDataSampleBuffer, error) -> Void in
                if (imageDataSampleBuffer != nil) {
                    // Capture data as jpeg format
                    let imageData : NSData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imageDataSampleBuffer)
                    
                    // Create UIImage from JPEG
                    let image = UIImage(data: imageData)
                    
                    UIImageWriteToSavedPhotosAlbum(image!, self, nil, nil)
                    let alertController = UIAlertController(title: "拍照完成啰", message:
                        "", preferredStyle: UIAlertControllerStyle.Alert)
                    alertController.addAction(UIAlertAction(title: "確定", style: UIAlertActionStyle.Default,handler: nil))
                    
                    self.presentViewController(alertController, animated: true, completion: nil)
                    // TODO change size etc...
                }
            })
        }
    }
}

