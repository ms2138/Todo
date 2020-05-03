//
//  Item.swift
//  Todo
//
//  Created by mani on 2020-05-03.
//  Copyright © 2020 mani. All rights reserved.
//

import Foundation

extension Item {
    func createdAtString(dateFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: createdAt)
    }
}
