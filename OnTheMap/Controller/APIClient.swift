//
//  getLocations.swift
//  OnTheMap
//
//  Created by user152630 on 6/13/19.
//  Copyright © 2019 user152630. All rights reserved.
//
import Foundation
import UIKit

class LocaitonsAccessor {
    let networkHelper = Network()
    let converter = Converter()
    let api = Constants.ApiCall()
    let studentLocation = Constants.studentLocation()
    
    
    func getLocation(_ limit: Int?, _ skip: Int?, _ order : String?, _ uniqueKey: String?, _ callbackFunc: @escaping (_ result: AnyObject?,_ error: NSError?)->Void) {
        
        let passedParameters = ["limit":limit ?? "",
                                "skip":skip ?? "",
                                "order":order ?? "",
                                "uniqueKey":uniqueKey ?? ""] as [String : AnyObject]
        let passedMethod = api.getAPIMultipleStudentLocations
        
        networkHelper.taskForGETMethod(passedMethod , parameters: passedParameters, completionHandlerForGET: callbackFunc)
    }
    
}
