//
//  Extension.swift
//  MSUploader
//
//  Created by Joyson  on 07/06/20.
//  Copyright © 2020 mobishala. All rights reserved.
//

import Foundation
import MobileCoreServices
extension URL{
   public func mimeTypeForPath() -> String {
        let pathExtension = self.pathExtension

     if let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension as NSString, nil)?.takeRetainedValue() {
            if let mimetype = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?.takeRetainedValue() {
                return mimetype as String
            }
        }
        return "application/octet-stream"
    }
}
