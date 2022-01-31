//
//  Task.swift
//  AppAgenda
//
//  Created by dcoxi on 1/27/22.
//

import Foundation

struct Task {
    var id = UUID()
    var nome: String = ""
    var data: Date = Date()
    var categoria: Category = Category(name: "Marketing", color: .black)
}
