//
//  File.swift
//  Project1
//
//  Created by Андрей Бородкин on 10.07.2021.
//

import Foundation

struct Picture: Comparable, Codable {
   
    var name: String
    var numberOfTaps = 0
    
    static func < (lhs: Picture, rhs: Picture) -> Bool {
        return lhs.name < rhs.name
    }
}
