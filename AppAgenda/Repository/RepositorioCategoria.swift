//
//  RepositorioCategoria.swift
//  AppAgenda
//
//  Created by dcoxi on 1/30/22.
//

import Foundation
import UIKit

class RepositorioCategoria {
   
    static func getCategoria() -> [Category] {
        let categorias = [
            Category(name: "Trabalho", color: UIColor.green),
            Category(name: "Estudo",   color: UIColor.blue),
            Category(name: "A fazer", color: UIColor.yellow),
            Category(name: "Lembrete", color: UIColor.red)
        ]
        
        return categorias;
    }
    
}
