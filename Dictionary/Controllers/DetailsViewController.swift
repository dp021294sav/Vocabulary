//
//  DetailsViewController.swift
//  Dictionary
//
//  Created by Андрей Сергиенко on 09.10.18.
//  Copyright © 2018 Андрей Сергиенко. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet private weak var englishLabel: UILabel!
    @IBOutlet private weak var russianLabel: UILabel!
    @IBOutlet private weak var button: UIButton!
    
    var isNewWord = true
    var word: Word?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        englishLabel.text = word?.englishWord
        russianLabel.text = word?.translate
        switch isNewWord {
        case true:
            button.setTitle("Запомнил", for: .normal)
        case false:
            button.setTitle("Вернуть", for: .normal)
        }
    }
    
    @IBAction func rememberedPressed(_ sender: Any) {
        guard let word = word else {return}
        navigationController?.popViewController(animated: true)
        switch isNewWord {
        case true:
            DataManager.instance.markAsRemembered(word: word)
        case false:
            DataManager.instance.addWord(word)
            DataManager.instance.removeFromVocabulary(word)
        }
    }
}
