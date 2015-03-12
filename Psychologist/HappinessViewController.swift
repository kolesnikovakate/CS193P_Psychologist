//
//  HappinessViewController.swift
//  Happiness
//
//  Created by Екатерина Колесникова on 01.03.15.
//  Copyright (c) 2015 kkate. All rights reserved.
//

import UIKit

class HappinessViewController: UIViewController, FaceViewDataSourse
{

    @IBOutlet weak var faceView: FaceView! {
        didSet {
            faceView.dataSourse = self
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: "scale:"))
        }
    }
    
    var happiness: Int = 10 { // 0 = sad, 100 = happy
        didSet {
            happiness = min(max(happiness, 0), 100)
            println("happiness = \(happiness)")
            updateUI()
        }
    }

    private struct Constants {
        static let HappinessGestureScale: CGFloat = 4
    }

    @IBAction func changeHappiness(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .Ended: fallthrough
        case .Changed:
            let translation = gesture.translationInView(faceView)
            let happinessChange = -Int(translation.y / Constants.HappinessGestureScale)
            if (happinessChange != 0) {
                happiness += happinessChange
                gesture.setTranslation(CGPointZero, inView: faceView)
            }
        default:
            break
        }
    }

    private func updateUI() {
        faceView?.setNeedsDisplay()
        title = "\(happiness)"
    }

    func smilenessForFaceView(sender: FaceView) -> Double? {
        return Double(happiness-50)/50
    }
}
