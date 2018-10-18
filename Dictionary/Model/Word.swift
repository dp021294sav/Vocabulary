//
//  Word.swift
//  Dictionary
//
//  Created by Андрей Сергиенко on 09.10.18.
//  Copyright © 2018 Андрей Сергиенко. All rights reserved.
//

import Foundation

struct Word {
    let englishWord: String
    let translate: String
}

extension Word: Equatable {
    static func == (lhs: Word, rhs: Word) -> Bool {
        return lhs.englishWord == rhs.englishWord && lhs.translate == rhs.translate
    }
}
