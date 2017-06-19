//
//  CollectionViewController.swift
//  Nathan
//
//  Created by Nathan on 3/17/17.
//  Copyright © 2017 Nathan. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    let imgarry = ["imm1.jpg","iimm2.jpg","imm3.jpeg"]
    let textarry = ["高尔夫球杆","高尔夫挥杆动作","高尔夫球场"]
    let pageControl:UIPageControl = {
       let pc = UIPageControl()
        pc.pageIndicatorTintColor = UIColor.lightGrayColor()
        pc.translatesAutoresizingMaskIntoConstraints = false
        pc.currentPageIndicatorTintColor = UIColor.orangeColor()
        pc.numberOfPages = 3
        return pc
        
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
     //   let backbar = UIBarButtonItem(title: "< Back", style: .Done, target: self, action: #selector(back))
      //  navigationItem.leftBarButtonItem = backbar
        view.addSubview(pageControl)
        pageControl.leftAnchor.constraintEqualToAnchor(view.leftAnchor).active = true
        pageControl.rightAnchor.constraintEqualToAnchor(view.rightAnchor).active = true
        pageControl.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor,constant: -40).active = true
        pageControl.heightAnchor.constraintEqualToConstant(40).active = true
        navigationItem.title = "高尔夫图片介绍"
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        navigationController?.navigationBar.translucent = false
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]

        collectionView?.backgroundColor = UIColor.whiteColor()
        collectionView?.pagingEnabled = true
        collectionView?.registerClass(collectionviewcell.self, forCellWithReuseIdentifier: "cellid")
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.bounces = false
        
    }
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    func back(){
        var gg = ViewController()
        
        let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appdelegate.window!.rootViewController = gg
    }
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    override func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let cp = targetContentOffset.move().x/view.frame.width
        pageControl.currentPage = Int(cp)%3
    }
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cv = collectionView.dequeueReusableCellWithReuseIdentifier("cellid", forIndexPath: indexPath) as! collectionviewcell
        cv.backgroundColor = UIColor.blueColor()
        cv.image.image = UIImage(named: imgarry[indexPath.item%3])
        cv.label.text = textarry[indexPath.item%3]
        return cv
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height-(navigationController?.navigationBar.frame.height)!)
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
}
