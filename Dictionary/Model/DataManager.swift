//
//  DataManager.swift
//  Dictionary
//
//  Created by Андрей Сергиенко on 09.10.18.
//  Copyright © 2018 Андрей Сергиенко. All rights reserved.
//

import Foundation

final class DataManager {
    static let instance = DataManager()
    private init() { }
    
    private (set) var newWords: [Word] = []
    private (set) var rememberedWords: [Word] = []
    
    func addWord(_ word: Word) {
        newWords.append(word)
    }
    
    func markAsRemembered(word: Word) {
        guard let removeIndex = newWords.index(of: word) else {return}
        newWords.remove(at: removeIndex)
        rememberedWords.append(word)
    }
    
    func removeFromVocabulary(_ word: Word) {
        guard let removeIndex = rememberedWords.index(of: word) else {return}
        rememberedWords.remove(at: removeIndex)
    }
    
    func removeRowFromVocabulary(index: Int) {
        rememberedWords.remove(at: index)
    }
    
    func moveRowsAtWordList(word: Word, moveFromIndex: Int, toIndex: Int) {
        newWords.remove(at: moveFromIndex)
        newWords.insert(word, at: toIndex)
    }
}
