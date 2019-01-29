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
    @IBOutlet weak var button: UIButton!
    
    var status:Bool = false
    
    let motion = CMMotionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func pushedButton(_ sender: Any) {
        if self.status {
            stopAccelerometer()
            button.setTitle("Start", for: .normal)
            self.status = false
        }else{
            startAccelerometer()
            button.setTitle("Stop", for: .normal)
            self.status = true
        }
    }
    
    /// Start Accelerometer Sensor
    func startAccelerometer(){
        // Make sure the accelerometer hardware is available.
        if self.motion.isAccelerometerAvailable {
            self.motion.accelerometerUpdateInterval = 1.0 / 60.0 // 60fps
            self.motion.startAccelerometerUpdates(to: .main) { (data, error) in
                // Get the accelerometer data.
                if let d = data {
                    let x = d.acceleration.x
                    let y = d.acceleration.y
                    let z = d.acceleration.z
                    
                    // Use the accelerometer data in your app.
                    self.xLabel.text = String(x)
                    self.yLabel.text = String(y)
                    self.zLabel.text = String(z)
                    
                    // Detect a motion of smartphone
                    if x > 1 {
                        print("x>1")
                        AudioServicesPlaySystemSound(1003)
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
    
    /// Stop Accelerometer Sensor
    func stopAccelerometer(){
        if self.motion.isAccelerometerActive {
            self.motion.stopAccelerometerUpdates()
        }
    }
    
}



