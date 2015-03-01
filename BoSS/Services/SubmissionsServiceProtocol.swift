//
//  SubmissionsServiceProtocol.swift
//  BoSS
//
//  Created by Emanuele Rudel on 28/02/15.
//  Copyright (c) 2015 Bureau of Street Services. All rights reserved.
//

import Foundation
import ReactiveCocoa

protocol SubmissionsServiceProtocol {
    
    func submissions() -> RACSignal?
    
}