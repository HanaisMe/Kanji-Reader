//
//  HistoryViewController.swift
//  KanjiReader
//
//  Created by Jeongsik Lee on 2020/02/19.
//  Copyright © 2020 Jeongsik Lee. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {
    
    @IBOutlet weak var historyTableview: UITableView!
    var histories = [History]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        historyTableview.dataSource = self
        historyTableview.delegate = self
        historyTableview.rowHeight = UITableView.automaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Worker.shared.fetchHistories(success: { [weak self] (histories) in
            self?.histories = histories
            self?.historyTableview.reloadData()
        }, failure: { (errorMessage) in // TODO: - handle failure
            print(errorMessage)
        })
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension HistoryViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return histories.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryTableViewCell_ID", for: indexPath) as! HistoryTableViewCell
        cell.setUI(with: histories[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for vc in (self.navigationController?.viewControllers ?? []) {
            if let converterVC = vc as? ConverterViewController {
                let record = histories[indexPath.row]
                converterVC.segmentedControl.selectedSegmentIndex = OutputType(rawValue: record.outputType) == .hiragana ? 0 : 1
                converterVC.inputTextView.text = record.sentence
                converterVC.outputTextView.text = record.converted
                _ = self.navigationController?.popToViewController(converterVC, animated: true)
                break
            }
        }
    }
}
