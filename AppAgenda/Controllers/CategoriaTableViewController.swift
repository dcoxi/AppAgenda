//
//  CategoriaTableViewController.swift
//  AppAgenda
//
//  Created by dcoxi on 1/30/22.
//

import UIKit

class CategoriaTableViewController: UITableViewController {

    let categorias = RepositorioCategoria.getCategoria()
    var categoriaEscolhida : ((Category)-> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

     
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categorias.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celula = tableView.dequeueReusableCell(withIdentifier: "EscolherCategoriaCell", for: indexPath)
        let categoria = categorias[indexPath.row]
        celula.textLabel?.text = categoria.name
        return celula
    }
   
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let categoria = categorias[indexPath.row]
        self.categoriaEscolhida!(categoria)
        self.navigationController?.popViewController(animated: true)
    }
    
    

}
