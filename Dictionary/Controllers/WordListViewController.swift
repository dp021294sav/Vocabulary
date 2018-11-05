//
//  WordListViewController.swift
//  Dictionary
//
//  Created by Андрей Сергиенко on 09.10.18.
//  Copyright © 2018 Андрей Сергиенко. All rights reserved.
//

import UIKit

class WordListViewController: UIViewController {
    // MARK: - Properties
    private var isSearchActive = false
    private var filteredWords: [Word] = []

    // MARK: - Outlets
    @IBOutlet private weak var editingStyleSwitch: UISwitch!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var searchBar: UISearchBar!
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Слова"
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
    
    @IBAction private func switchValueChanged(_ sender: Any) {
        if editingStyleSwitch.isOn == true {
            tableView.isEditing = true
        } else {
            tableView.isEditing = false
        }
    }
    
    // MARK: - Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showDetails" else {return}
        guard let destVC = segue.destination as? DetailsViewController else {return}
        guard let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) else {return}
        let word = DataManager.instance.newWords[indexPath.row]
        destVC.word = word
    }
    
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension WordListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearchActive ? filteredWords.count : DataManager.instance.newWords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewWordTableViewCell", for: indexPath) as? NewWordTableViewCell else {
            fatalError("Cell is not created")
        }
        let word = isSearchActive ? filteredWords[indexPath.row] : DataManager.instance.newWords[indexPath.row]
        cell.update(englishWord: word.englishWord)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }

    func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath,
                   to: IndexPath) {
        let word = DataManager.instance.newWords[fromIndexPath.row]
        DataManager.instance.moveRowsAtWordList(word: word, moveFromIndex: fromIndexPath.row, toIndex: to.row)
    }
}

// MARK: - UISearchBarDelegate
extension WordListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredWords = []
        
        isSearchActive = !searchText.isEmpty
        
        for item in DataManager.instance.newWords {
            if item.englishWord.lowercased() .contains(searchText.lowercased()) {
                filteredWords.append(item)
            }
        }
        tableView.reloadData()
    }
}
