//
//  MSUploadManager.swift
//  MSUploader
//
//  Created by Joyson  on 07/06/20.
//  Copyright © 2020 mobishala. All rights reserved.
//

import Foundation
import AWSS3

public class UploadManager{
    public let transferUtility = AWSS3TransferUtility.default()
    public var uploadTask = AWSS3TransferUtilityUploadTask()
    public init(){}
    public func resumeUploadingTask(){
        uploadTask.resume()
    }
    public func pauseUploadingTask(){
        uploadTask.suspend()

    }
    public func cancelUploading(){
        uploadTask.cancel()
    }
    public func uploadFile(filepath: String,bucketName:String,progrssHandler:@escaping (Progress)->Void ,completionHandler: @escaping (Bool,Any) -> Void){
            let progrressBlock : AWSS3TransferUtilityProgressBlock = { task, progress in
                  progrssHandler(progress)
            }
            let url = URL(fileURLWithPath: filepath)
            let fileExt = url.pathExtension
            let name = ProcessInfo.processInfo.globallyUniqueString + "." + fileExt
            let expression = AWSS3TransferUtilityUploadExpression()
            let contentType = url.mimeTypeForPath()
            expression.progressBlock = progrressBlock
            if let data = try? Data(contentsOf: url){
             let task = transferUtility.uploadData(data, bucket: bucketName, key: name, contentType: "\(contentType)/\(fileExt)", expression: expression)
             task.continueWith { (task) -> Any? in
                    if let error = task.error {
                        completionHandler(false,error.localizedDescription)
                            return nil
                        }
                        if let uploadTask = task.result {
                            self.uploadTask = uploadTask
                            completionHandler(true,uploadTask)
                        }
                return task
            }
        }else{
        completionHandler(false,"Unable to read the contents from the file")

        }
    }
}

