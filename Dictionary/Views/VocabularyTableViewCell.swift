//
//  VocabularyTableViewCell.swift
//  Dictionary
//
//  Created by Андрей Сергиенко on 10.10.18.
//  Copyright © 2018 Андрей Сергиенко. All rights reserved.
//

import UIKit

class VocabularyTableViewCell: UITableViewCell {

    @IBOutlet private weak var iconView: UIView!
    @IBOutlet private weak var englishLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        iconView.layer.cornerRadius = iconView.bounds.width / 2
        selectionStyle = .none
    }

    func update(englishWord: String, translate: String) {
        englishLabel.text = englishWord
    }
}
