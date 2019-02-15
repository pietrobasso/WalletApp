//
//  UICollectionViewCell+Rx+DisposeBag.swift
//  lisca
//
//  Created by Pietro Basso on 28/09/2017.
//  Copyright © 2017 Rawfish. All rights reserved.
//

import RxSwift
import RxCocoa

private var prepareForReuseBag: Int8 = 0

extension Reactive where Base: UICollectionViewCell {
    var prepareForReuse: Observable<Void> {
        return Observable.of(sentMessage(#selector(UICollectionViewCell.prepareForReuse)).map { _ in () }, deallocated).merge()
    }
    
    
    /// Dispose Bag for Collection View Cell.
    ///
    /// Using RxSwift with UICollectionView, we may need to subscribe to observables in each cell.
    /// If cell are reused, there are chances that we will subscribe an Observable more than once on a cell.
    /// ## Why is this useful?
    /// To avoid duplicate subscriptions to an Observable.
    /// ## Example
    ///
    ///     cell.button.rx.tap
    ///         .bind(to: something)
    ///         .disposed(by: cell.rx.disposeBag)
    ///
    ///
    /// - Note: See also this [issue on RxSwift Repository](https://github.com/ReactiveX/RxSwift/issues/821#issuecomment-301429488).
    var disposeBag: DisposeBag {
        MainScheduler.ensureExecutingOnScheduler()
        
        if let bag = objc_getAssociatedObject(base, &prepareForReuseBag) as? DisposeBag {
            return bag
        }
        
        let bag = DisposeBag()
        objc_setAssociatedObject(base, &prepareForReuseBag, bag, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        
        _ = sentMessage(#selector(UICollectionViewCell.prepareForReuse))
            .subscribe(onNext: { [weak base] _ in
                let newBag = DisposeBag()
                objc_setAssociatedObject(base, &prepareForReuseBag, newBag, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            })
        
        return bag
    }
}
