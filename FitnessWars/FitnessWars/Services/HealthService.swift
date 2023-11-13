//
//  HealthService.swift
//  FitnessWars
//
//  Created by Jeremy Barr on 11/5/23.
//

import Foundation
import HealthKit

class HealthService {
    
    private enum HealthkitSetupError: Error {
      case notAvailableOnDevice
      case dataTypeNotAvailable
    }

    
    class func authorizeHealthKit(completion: @escaping (Bool, Error?) -> Swift.Void) {
        //1. Check to see if HealthKit Is Available on this device
        guard HKHealthStore.isHealthDataAvailable() else {
          completion(false, HealthkitSetupError.notAvailableOnDevice)
          return
        }
        
        guard let stepCount = HKObjectType.quantityType(forIdentifier: .stepCount),
              let distanceMoving = HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning),
              let runningSpeed = HKObjectType.quantityType(forIdentifier: .runningSpeed),
              let energyBurned = HKObjectType.quantityType(forIdentifier: .activeEnergyBurned) else {
            completion(false, HealthkitSetupError.dataTypeNotAvailable)
            return
        }
        
        let healthKitTypesToWrite: Set<HKSampleType> = [HKObjectType.workoutType()]
        
        let healthKitTypesToRead: Set<HKObjectType> = [stepCount,
                                                        distanceMoving,
                                                        runningSpeed,
                                                        energyBurned,
                                                        HKObjectType.workoutType()]
        HKHealthStore().requestAuthorization(toShare: healthKitTypesToWrite, read: healthKitTypesToRead) { success, error in
            completion(success, error)
        }
    }

}
