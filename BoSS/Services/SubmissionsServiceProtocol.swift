//
//  SubmissionsServiceProtocol.swift
//  BoSS
//
//  Created by Emanuele Rudel on 28/02/15.
//  Copyright (c) 2015 Bureau of Street Services. All rights reserved.
//

import Foundation

protocol SubmissionsServiceProtocol: BaseServiceProtocol {
    
    func submissions() -> RACSignal
    
    func upload(image: UIImage) -> RACSignal
    
    func create(submission: Submission) -> RACSignal
    
}