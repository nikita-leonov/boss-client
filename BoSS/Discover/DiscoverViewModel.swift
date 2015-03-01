//
//  DiscoverViewModel.swift
//  BoSS
//
//  Created by Emanuele Rudel on 01/03/15.
//  Copyright (c) 2015 Bureau of Street Services. All rights reserved.
//

import Foundation

class DiscoverViewModel {
    
    internal var submissions = [Submission]()
    
    private let submissionsService: SubmissionsServiceProtocol
    
    required init(submissionsService: SubmissionsServiceProtocol) {
        self.submissionsService = submissionsService
    }
    
    func readSubmissions() -> RACSignal {
        return submissionsService.submissions().doNext { [weak self] (x) -> Void in
            if let newSubmissions = x as? [Submission] {
                self?.submissions = newSubmissions
            }
        }
    }
    
}