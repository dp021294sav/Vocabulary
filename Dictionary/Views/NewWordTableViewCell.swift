//
//  NewWordTableViewCell.swift
//  Dictionary
//
//  Created by Андрей Сергиенко on 09.10.18.
//  Copyright © 2018 Андрей Сергиенко. All rights reserved.
//

import UIKit

class NewWordTableViewCell: UITableViewCell {

    @IBOutlet private weak var iconView: UIView!
    @IBOutlet private weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        iconView.layer.cornerRadius = iconView.bounds.width / 2
        selectionStyle = .none
    }

    func update(englishWord: String) {
        nameLabel.text = englishWord
    }
}
