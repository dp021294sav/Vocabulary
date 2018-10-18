//
//  VocabularyViewController.swift
//  Dictionary
//
//  Created by Андрей Сергиенко on 10.10.18.
//  Copyright © 2018 Андрей Сергиенко. All rights reserved.
//

import UIKit

class VocabularyViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Мой словарь"
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showInfo" else {return}
        guard let destVC = segue.destination as? DetailsViewController else {return}
        guard let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) else {return}
        let word = DataManager.instance.rememberedWords[indexPath.row]
        destVC.word = word
        destVC.isNewWord = false
    }
}

extension VocabularyViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.instance.rememberedWords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VocabularyTableViewCell", for: indexPath) as! VocabularyTableViewCell
        let word = DataManager.instance.rememberedWords[indexPath.row]
        cell.update(englishWord: word.englishWord)
        return cell
    }
}
