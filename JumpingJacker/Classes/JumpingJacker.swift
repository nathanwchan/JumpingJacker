//
//  JumpingJacker.swift
//  JumpingJacker
//
//  Created by Nathan Chan on 7/27/17.
//  Copyright © 2017 Nathan Chan. All rights reserved.
//

import Foundation
import CoreMotion

enum Direction {
    case Up, Down, Unknown
}

// The sensitivity coefficient for the jumping jack movement. "Low" sensitivity means that a more exaggerated jumping jack movement is required to register a jumping jack.
enum MovementSensitivity: Double {
    case low = 0.7
    case normal = 0.5
    case high = 0.3
}

protocol JumpingJackerDelegate
{
    /// Called when a jumping jack is completed
    ///
    /// - Parameter jumpingJacker: the jumpingJacker instance
    func jumpingJackerDidJumpingJack(_ jumpingJacker: JumpingJacker)
    
    /// Called when something goes wrong
    ///
    /// - Parameter jumpingJacker: the jumpingJacker instance
    /// - Parameter error: error which occurred
    func jumpingJacker(_ jumpingJacker: JumpingJacker, didFailWith error: Error)
}

public class JumpingJacker
{
    public var delegate: JumpingJackerDelegate?
    
    var motionManager: CMMotionManager!
    var lastValueX: Double?
    var lastValueY: Double?
    var lastValueZ: Double?
    
    var sensitivity: Double
    var intervalsSinceLastDirectionChange: Int = 0
    var direction: Direction = .Unknown {
        didSet {
            self.intervalsSinceLastDirectionChange = 0
        }
    }
    
    /// init
    ///
    /// - Parameter movementSensitivity: The sensitivity coefficient for the jumping jack movement. "Low" sensitivity means that a more exaggerated jumping jack movement is required to register a jumping jack.
    
    init(movementSensitivity to: MovementSensitivity) {
        self.sensitivity = to.rawValue
        self.motionManager = CMMotionManager()
    }
    
    /// start
    ///
    /// - Parameter accelerometerUpdateInterval: (optional; default is 0.1)
    public func start(accelerometerUpdateInterval: Double = 0.1)
    {
        guard motionManager.isAccelerometerAvailable else { return }
        motionManager.accelerometerUpdateInterval = accelerometerUpdateInterval
        
        let accelerometerQueue = OperationQueue()
        
        motionManager.startAccelerometerUpdates(to: accelerometerQueue) { (accelerometerData, err) -> Void in
            guard err == nil else
            {
                self.delegate?.jumpingJacker(self, didFailWith: err!)
                return
            }
            guard let data = accelerometerData else
            {
                let e = NSError(domain: "No accelerometer data", code: 0, userInfo: nil)
                self.delegate?.jumpingJacker(self, didFailWith: e)
                return
            }
            let valueX = data.acceleration.x
            let valueY = data.acceleration.y
            let valueZ = data.acceleration.z
            if let lastValueX = self.lastValueX,
                let lastValueY = self.lastValueY,
                let lastValueZ = self.lastValueZ {
                let distance = sqrt(pow(lastValueX - valueX, 2) + pow(lastValueY - valueY, 2) + pow(lastValueZ - valueZ, 2))
                if distance > 1 && self.intervalsSinceLastDirectionChange > Int(round(0.3 / accelerometerUpdateInterval)) {
                    if valueX + self.sensitivity < lastValueX {
                        // Up motion detected
                        if self.direction != .Up {
                            self.direction = .Up
                        }
                    } else if valueX - self.sensitivity > lastValueX {
                        if self.direction != .Down {
                            if self.direction == .Up {
                                self.delegate?.jumpingJackerDidJumpingJack(self)
                            }
                            self.direction = .Down
                        }
                    }
                }
            }
            self.lastValueX = valueX
            self.lastValueY = valueY
            self.lastValueZ = valueZ
            self.intervalsSinceLastDirectionChange += 1
        }
    }
    
    func stop()
    {
        motionManager.stopAccelerometerUpdates()
    }
}
