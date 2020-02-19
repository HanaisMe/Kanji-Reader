//
//  HistoryViewController.swift
//  KanjiReader
//
//  Created by Jeongsik Lee on 2020/02/19.
//  Copyright © 2020 Jeongsik Lee. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController, ViperView {

    typealias PresenterType = HistoryPresenter
    var presenter: HistoryPresenter?
    
    @IBOutlet weak var historyTableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        historyTableview.dataSource = self
        historyTableview.delegate = self
        historyTableview.rowHeight = UITableView.automaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.fetchHistories()
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.historyTableview.reloadData()
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension HistoryViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.histories.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryTableViewCell_ID", for: indexPath) as! HistoryTableViewCell
        if let record = presenter?.histories[indexPath.row] {
            cell.setUI(with: record)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.selectHistory(at: indexPath.row)
    }
}
