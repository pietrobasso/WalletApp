//
//  UserViewController.swift
//  wallet
//
//  Created by Pietro Basso on 20/02/2019.
//  Copyright (c) 2019 Pietro Basso. All rights reserved.
//
//  This file was generated by the Lisca Xcode Templates so
//  you can apply lisca architecture to your iOS projects
//

import UIKit
import RxSwift
import RxCocoa

protocol UserViewControllerInput {
    var title: Driver<String> { get }
    var dataSource: Driver<[Section<Action.Descriptor>]> { get }
}

protocol UserViewControllerOutput {
    var action: AnyObserver<UserAction> { get }
}

enum UserAction {
    case viewLoaded
    case didTapCellAt(IndexPath)
}

class UserViewController: UIViewController {
    
    let input: UserViewControllerInput
    let output: UserViewControllerOutput
    private let disposeBag = DisposeBag()
    private var dataSource = [Section<Action.Descriptor>]()
    
    // MARK: - Views
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.rowHeight = 52
        tableView.backgroundColor = Theme.current().backgroundColor
        tableView.showsVerticalScrollIndicator = false
        tableView.keyboardDismissMode = .interactive
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        tableView.tableFooterView = UIView()
        tableView.register(cellType: ActionCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Lifecycle
    
    init(input: UserViewControllerInput, output: UserViewControllerOutput) {
        self.input = input
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
        addSubviews()
        setupBindings()
        output.action.onNext(.viewLoaded)
    }

    private func setupAppearance() {
        view.backgroundColor = Theme.current().backgroundColor
    }
    
    private func addSubviews() {
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    private func setupBindings() {
        input.title.asObservable()
            .bind(to: rx.title)
            .disposed(by: disposeBag)
        input.title.asObservable()
            .subscribe(onNext: { [weak self] (title) in
                self?.title = title
                self?.tabBarItem.title = title
            })
            .disposed(by: disposeBag)
        input.dataSource
            .drive(onNext: { [weak self] (dataSource) in
                self?.dataSource = dataSource
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - Extension: UITableViewDataSource
extension UserViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[safe: section]?.dataSource.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as ActionCell
        guard let viewModel = dataSource[safe: indexPath.section]?.dataSource[safe: indexPath.row] else { return cell }
        cell.configure(with: viewModel)
        cell.rx.tap
            .asSignal()
            .throttle(0.1, latest: false)
            .emit(onNext: { [weak self] _ in
                self?.output.action.onNext(.didTapCellAt(indexPath))
            })
            .disposed(by: cell.rx.disposeBag)
        cell.rx.switchIsOn
            .asSignal(onErrorJustReturn: false)
            .skip(1)
            .debounce(0.2)
            .emit(onNext: { [weak self] (isOn) in
                self?.output.action.onNext(.didTapCellAt(indexPath))
            })
            .disposed(by: cell.rx.disposeBag)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return dataSource[safe: section]?.descriptor.headerView
    }
}

// MARK: - Extension: UITableViewDelegate
extension UserViewController: UITableViewDelegate {
    
}
