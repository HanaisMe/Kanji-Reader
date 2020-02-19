//
//  HistoryTableViewCell.swift
//  KanjiReader
//
//  Created by Jeongsik Lee on 2020/02/19.
//  Copyright © 2020 Jeongsik Lee. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var outputTypeLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        outputTypeLabel.text = nil
        contentLabel.text = nil
    }
    
    /// display the record
    func setUI(with history: History) {
        outputTypeLabel.text = history.outputType
        contentLabel.text = history.sentence + "→" + history.converted
    }
}
