//
//  CoreMotionService.swift
//  InRoad
//
//  Created by Адема Сапакова on 27.03.2023.
//

import CoreMotion

struct CoreMotionViewModel {
    var xPosition: Double
    var yPosition: Double
    var zPosition: Double
}

protocol CoreMotionServiceDelegate: AnyObject {
    func getCoordinateMotionDevice(with data: CoreMotionViewModel)
}

final class CoreMotionService {
    let motionManager = CMMotionManager()
    let motionQueue = OperationQueue()
    
    weak var delegate: CoreMotionServiceDelegate?
    
    func startMotion() {
        motionManager.startDeviceMotionUpdates(to: motionQueue) { [weak self]
            (data: CMDeviceMotion?, error: Error?) in
            
            guard let self = self,
                  let data = data else {
                return
            }
            
            let motion: CMAttitude = data.attitude
            self.motionManager.deviceMotionUpdateInterval = 0.6
            
            self.delegate?.getCoordinateMotionDevice(with: .init(xPosition: motion.roll,
                                                                 yPosition: motion.yaw,
                                                                 zPosition: motion.pitch))
        }
    }
}
