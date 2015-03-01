//
//  DiscoverViewModel.swift
//  BoSS
//
//  Created by Emanuele Rudel on 01/03/15.
//  Copyright (c) 2015 Bureau of Street Services. All rights reserved.
//

import Foundation

class DiscoverViewModel: NSObject {
    
    private let accessService: AccessServiceProtocol
    
    internal dynamic private(set) var accessToken: String?
    
    internal private(set) var signupEnabled: RACSignal!
    
    required init(accessService: AccessServiceProtocol) {
        self.accessService = accessService
        super.init()
        signupEnabled = rac_valuesForKeyPath("accessToken", observer: self).ignore(nil).mapReplace(true)
        
        accessService.getToken().subscribeNextAs { [weak self] (response: [String: String]) in
            _ = self?.accessToken = response["token"]!
        }
    }
    
}