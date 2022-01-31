//
//  NovaTarefaViewController.swift
//  AppAgenda
//
//  Created by dcoxi on 1/28/22.
//

import UIKit

class NovaTarefaViewController: UITableViewController, UITextFieldDelegate {
    
    private var data: UIDatePicker = UIDatePicker()
    private var formatoData = DateFormatter()
    private var selectedIndexPath: IndexPath?
    
    private var tarefaRepositorio = RepositorioTarefa.instance
    
    var tarefa: Task = Task()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatoData.dateFormat = "dd/MM/yyyy HH:mm"
        data.datePickerMode = .dateAndTime
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return "Tarefa"
        }
        if section == 1 {
            return "Categoria"
        }
        return "Data Hora"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 0)
        {
        let celula = tableView.dequeueReusableCell(withIdentifier: "DescricaoTarefaCell",for: indexPath) as! TarefaDescricaoTableViewCell
            celula.txtDescricaoTarefa.delegate = self
            return celula
        }
        if(indexPath.section == 1)
        {
        let celula = tableView.dequeueReusableCell(withIdentifier: "CategoriaTarefaCell",for: indexPath)
            celula.textLabel?.text = self.tarefa.categoria.name
            return celula
            
        }
        
        let celula = tableView.dequeueReusableCell(withIdentifier: "DataHoraCell", for: indexPath) as! DataHoraTableViewCell
        celula.txtDataHora.inputView = data
        celula.txtDataHora.delegate = self
        celula.txtDataHora.inputAccessoryView = accessoryView()
        return celula
        
        
    }
    
    //MARK - Action buttons

    @IBAction func tapBotaoSalvar(_ sender: Any) {
        tarefaRepositorio.salvar(tarefa: tarefa)
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK - UITextFieldDelegate Methods
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let celula = textField.superview?.superview as? DataHoraTableViewCell
        if let dateCell = celula {
            self.selectedIndexPath = tableView.indexPath(for: dateCell)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        let celula = textField.superview?.superview as? TarefaDescricaoTableViewCell
        self.tarefa.nome = textField.text!
    }
    
    //Mark - UIView Functions
    
    func accessoryView() -> UIView {
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        let barItemSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action:nil)
        let doneButton   = UIBarButtonItem(title: "Feito", style: .done, target: self, action:
            #selector(NovaTarefaViewController.selecionarData))
        toolBar.setItems([barItemSpace, doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        
        return toolBar
    }
    @objc func selecionarData() {
        if let indexPath = self.selectedIndexPath {
            let celula = tableView.cellForRow(at: indexPath) as? DataHoraTableViewCell
            if let dateCell = celula {
                dateCell.txtDataHora.text = formatoData.string(from: data.date)
                self.view.endEditing(true)
                self.tarefa.data = data.date
            }
            
        }
        

    }
    
    
    //MARK - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "paraCategoriaTableViewController"{
            let destino = segue.destination as! CategoriaTableViewController
            destino.categoriaEscolhida = {categoria in
                self.tarefa.categoria = categoria
                self.tableView.reloadData()
            }
        }
    }
    
}
