//
//  ViewController.swift
//  HelloAcc
//
//  Created by Yuuki Nishiyama on 2019/01/29.
//  Copyright © 2019 Yuuki Nishiyama. All rights reserved.
//

import UIKit
import CoreMotion
import AudioToolbox

class ViewController: UIViewController{

    @IBOutlet weak var xLabel: UILabel!
    @IBOutlet weak var yLabel: UILabel!
    @IBOutlet weak var zLabel: UILabel!
    @IBOutlet weak var compLabel: UILabel!
    
    var status:Bool = false
    
    let motion = CMMotionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func pushedButton(_ sender: Any) {
        if self.status {
            stopAccelerometer()
            self.status = false
        }else{
            startAccelerometer()
            self.status = true
        }
    }
    
    func startAccelerometer(){
        // Make sure the accelerometer hardware is available.
        if self.motion.isAccelerometerAvailable {
            self.motion.accelerometerUpdateInterval = 1.0 / 60.0 // 60fps
            self.motion.startAccelerometerUpdates(to: .main) { (data, error) in
                // Get the accelerometer data.
                if let data = self.motion.accelerometerData {
                    let x = data.acceleration.x
                    let y = data.acceleration.y
                    let z = data.acceleration.z
                    
                    let comp = sqrt( x*x + y*y + z*z )
                    
                    // Use the accelerometer data in your app.
                    self.xLabel.text = String(format: "x:%.2f", x)
                    self.yLabel.text = String(format: "y:%.2f", y)
                    self.zLabel.text = String(format: "z:%.2f", z)
                    self.compLabel.text = String(format: "composit:%.2f", comp)
                    
                    if x > 1 {
                        print("x>1")
                        // AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
                        AudioServicesPlaySystemSound(1001)
                    }else if y > 1 {
                        print("y>1")
                        AudioServicesPlaySystemSound(1004) // SMSReceived_Alert
                    }else if z > 1 {
                        print("z>1")
                        AudioServicesPlaySystemSound(1016) // SMSSent
                    }
                }
            }
        }
    }
    
    func stopAccelerometer(){
        if self.motion.isAccelerometerActive {
            self.motion.stopAccelerometerUpdates()
        }
    }
    
}



