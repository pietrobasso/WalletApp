//
//  Result.swift
//  lisca
//
//  Created by Pietro Basso on 19/12/2018.
//  Copyright © 2018 Rawfish. All rights reserved.
//

enum Result<T, Error> {
    case success(T)
    case failure(Error)
    
    init(value: T) {
        self = .success(value)
    }
    
    init(error: Error) {
        self = .failure(error)
    }
    
    func map<U>(_ transform: (T) -> U) -> Result<U, Error> {
        switch self {
        case .success(let x): return .success(transform(x))
        case .failure(let e): return .failure(e)
        }
    }
}
