//
//  LocalAuthenticationService+Rx.swift
//  wallet
//
//  Created by Pietro Basso on 20/02/2019.
//  Copyright © 2019 Pietro Basso. All rights reserved.
//

import RxSwift
import RxCocoa

extension LocalAuthenticationServiceImplementation: ReactiveCompatible {}

extension Reactive where Base: LocalAuthenticationService {
    func authenticate() -> Single<Result<Bool, Error>> {
        return Single.create { (single) in
            self.base.authenticate() { (result) in
                single(.success(result))
            }
            return Disposables.create()
        }
        .subscribeOn(MainScheduler.instance)
    }
}
