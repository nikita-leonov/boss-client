//
//  LocationServiceProtocol.swift
//  BoSS
//
//  Created by Nikita Leonov on 2/28/15.
//  Copyright (c) 2015 Bureau of Street Services. All rights reserved.
//

import ReactiveCocoa

protocol LocationServiceProtocol: BaseServiceProtocol {
    func currentLocation() -> RACSignal
}