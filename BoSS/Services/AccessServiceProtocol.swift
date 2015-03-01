//
//  AccessServiceProtocol.swift
//  BoSS
//
//  Created by Emanuele Rudel on 01/03/15.
//  Copyright (c) 2015 Bureau of Street Services. All rights reserved.
//

import Foundation

protocol AccessServiceProtocol: BaseServiceProtocol {
    
    func getToken() -> RACSignal
    
}