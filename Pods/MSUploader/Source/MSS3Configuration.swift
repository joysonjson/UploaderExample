//
//  MSS3Configuration.swift
//  MSUploader
//
//  Created by Joyson  on 07/06/20.
//  Copyright © 2020 mobishala. All rights reserved.
//

import Foundation
import AWSCore


public class ConfigureUploader {
    public static func config(regionType:AWSRegionType,identityPoolId:String){
        let credentialsProvider = AWSCognitoCredentialsProvider(regionType:regionType,
                  identityPoolId:identityPoolId)
        let configuration = AWSServiceConfiguration(region:regionType, credentialsProvider:credentialsProvider)
        AWSServiceManager.default().defaultServiceConfiguration = configuration
    }
}
