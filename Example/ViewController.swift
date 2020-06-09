//
//  ViewController.swift
//  Example
//
//  Created by Joyson  on 09/06/20.
//  Copyright © 2020 mobishala. All rights reserved.
//

import UIKit
import MSUploader
class ViewController: UIViewController {
    
    
    @IBOutlet weak var progressIndicator: UILabel!
    let manager = UploadManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    @IBAction func uploadVideo(_ sender: Any) {
        guard let path = Bundle.main.path(forResource: "test1", ofType:"mp4") else {
                      debugPrint("video.m4v not found")
                      return
                  }
              
              manager.uploadFile(filepath: path, bucketName: "msannotevideo", progrssHandler: { (progress) in
                  print(progress.fractionCompleted)
                DispatchQueue.main.async {
                    self.progressIndicator.text = "\(progress.fractionCompleted)"
                }
        
              }) { (status, task) in
                  if (status){
                      print("Sucessfully uploaded ")
                  }else{
                      print("Failed to upload")
                  }
              }
    }
    
    @IBAction func pauseUpload(_ sender: Any) {
        manager.pauseUploadingTask()
       
    }
   @IBAction func resumeUpload(_ sender: Any) {
    manager.resumeUploadingTask()
      
    }
  @IBAction func cancelUpload(_ sender: Any) {
    manager.cancelUploading()
     
    }
             
}

