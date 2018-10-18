//
//  WordListViewController.swift
//  Dictionary
//
//  Created by Андрей Сергиенко on 09.10.18.
//  Copyright © 2018 Андрей Сергиенко. All rights reserved.
//

import UIKit

class WordListViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        title = "Слова"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showDetails" else {return}
        guard let destVC = segue.destination as? DetailsViewController else {return}
        guard let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) else {return}
        let word = DataManager.instance.newWords[indexPath.row]
        destVC.word = word
    }
}

extension WordListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.instance.newWords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewWordTableViewCell", for: indexPath) as! NewWordTableViewCell
        let word = DataManager.instance.newWords[indexPath.row]
        cell.update(englishWord: word.englishWord, translate: word.translate)
        return cell
    }
}
