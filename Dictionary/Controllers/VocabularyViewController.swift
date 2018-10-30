//
//  VocabularyViewController.swift
//  Dictionary
//
//  Created by Андрей Сергиенко on 10.10.18.
//  Copyright © 2018 Андрей Сергиенко. All rights reserved.
//

import UIKit

class VocabularyViewController: UIViewController {

    private var isSearchActive = false
    private var filteredWords: [Word] = []
    
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Мой словарь"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.keyboardDismissMode = .onDrag
        searchBar.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
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
        return isSearchActive ? filteredWords.count :
            DataManager.instance.rememberedWords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VocabularyTableViewCell", for: indexPath) as! VocabularyTableViewCell
        let word = isSearchActive ? filteredWords[indexPath.row] : DataManager.instance.rememberedWords[indexPath.row]
        cell.update(englishWord: word.englishWord, translate: word.translate)
        return cell
    }
}

extension VocabularyViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredWords = []
        
        isSearchActive = !searchText.isEmpty
        
        for item in DataManager.instance.rememberedWords {
            if item.englishWord.lowercased() .contains(searchText.lowercased()) || item.translate.lowercased().contains(searchText.lowercased()) {
                filteredWords.append(item)
            }
        }
        tableView.reloadData()
    }
}
