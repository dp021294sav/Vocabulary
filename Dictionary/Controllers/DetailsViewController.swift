//
//  DetailsViewController.swift
//  Dictionary
//
//  Created by Андрей Сергиенко on 09.10.18.
//  Copyright © 2018 Андрей Сергиенко. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    // MARK: - Properties
    var isNewWord = true
    var word: Word?
    
    // MARK: - Outlets
    @IBOutlet private weak var englishLabel: UILabel!
    @IBOutlet private weak var russianLabel: UILabel!
    @IBOutlet private weak var button: UIButton!
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        englishLabel.text = word?.englishWord
        russianLabel.text = word?.translate
        if isNewWord == true {
            button.setTitle("Запомнил", for: .normal)
        } else {
            button.setTitle("Вернуть", for: .normal)
        }
        
    }
    
    @IBAction func rememberedPressed(_ sender: Any) {
        guard let word = word else {return}
        navigationController?.popViewController(animated: true)
        if isNewWord == true {
            DataManager.instance.markAsRemembered(word: word)
        } else {
            DataManager.instance.addWord(word)
            DataManager.instance.removeFromVocabulary(word)
        }
    }
}
