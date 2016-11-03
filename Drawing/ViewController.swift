//
//  ViewController.swift
//  Drawing
//
//  Created by Shannan Hsiao on 11/2/16.
//  Copyright © 2016 Shannan Hsiao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var lastPoint = CGPoint.zero
    var swiped = false

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        swiped = false
        
        if let touch = touches.first{
            lastPoint = touch.location(in: self.view)
        }
    }
    
    func drawLines(fromPoint: CGPoint, toPoint: CGPoint){
        UIGraphicsBeginImageContext(self.view.frame.size)
        imageView.image?.draw(in: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        let context = UIGraphicsGetCurrentContext()
        
        context?.move(to: CGPoint(x: fromPoint.x, y: fromPoint.y))
        context?.addLine(to: CGPoint(x: toPoint.x, y: toPoint.y))
        
        context?.setBlendMode(CGBlendMode.normal)
        context?.setLineCap(CGLineCap.round)
        context?.setLineWidth(4)
        context?.setStrokeColor(UIColor(red: 0, green: 0, blue: 0, alpha: 1.0).cgColor)
        
        context?.strokePath()
        imageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first{
            let currentPoint = touch.location(in: self.view)
            drawLines(fromPoint: lastPoint, toPoint: currentPoint)
            
            lastPoint = currentPoint
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        swiped = true
        
        if !swiped{
            drawLines(fromPoint:  lastPoint, toPoint: lastPoint)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

