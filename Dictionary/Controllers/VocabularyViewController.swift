//
//  VocabularyViewController.swift
//  Dictionary
//
//  Created by Андрей Сергиенко on 10.10.18.
//  Copyright © 2018 Андрей Сергиенко. All rights reserved.
//

import UIKit

class VocabularyViewController: UIViewController {

    // MARK: - Properties
    private var isSearchActive = false
    private var filteredWords: [Word] = []
    
    // MARK: - Outlets
    
    @IBOutlet private weak var editingStyleSwitch: UISwitch!
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Мой словарь"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.keyboardDismissMode = .onDrag
        searchBar.delegate = self
        editingStyleSwitch.isOn = false
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
    @IBAction func switchValueChanged(_ sender: Any) {
        if editingStyleSwitch.isOn == true {
            tableView.isEditing = true
        } else {
            tableView.isEditing = false
        }
    }
    
    // MARK: - Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showInfo" else {return}
        guard let destVC = segue.destination as? DetailsViewController else {return}
        guard let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) else {return}
        let word = DataManager.instance.rememberedWords[indexPath.row]
        destVC.word = word
        destVC.isNewWord = false
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension VocabularyViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearchActive ? filteredWords.count :
            DataManager.instance.rememberedWords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "VocabularyTableViewCell", for: indexPath) as? VocabularyTableViewCell else {
            fatalError("Cell is not created")
        }
        let word = isSearchActive ? filteredWords[indexPath.row] : DataManager.instance.rememberedWords[indexPath.row]
        cell.update(englishWord: word.englishWord, translate: word.translate)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCellEditingStyle,
                   forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {return}
        DataManager.instance.removeRowFromVocabulary(index: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
}

// MARK: - UISearchBarDelegate
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
