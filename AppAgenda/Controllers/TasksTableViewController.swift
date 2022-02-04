//
//  TasksTableViewController.swift
//  AppAgenda
//
//  Created by dcoxi on 1/27/22.
//

import UIKit


class TasksTableViewController: UITableViewController {

    private var dateFormatter: DateFormatter = DateFormatter()
    
    private var tarefas: [Task] = []
    private var tarefaRepositorio = RepositorioTarefa.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        tarefas = RepositorioTarefa.instance.getTarefas()
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tarefas.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskTableViewCell
        let task = tarefas[indexPath.row]
        
        dateFormatter.dateFormat = "HH:mm"
        cell.lblHora.text = dateFormatter.string(from: task.data)
        
        dateFormatter.dateFormat = "dd/MM/yyyy"
        cell.lblData.text = dateFormatter.string(from: task.data)
        
        cell.lblCategoria.text = task.categoria.name
        cell.lblView.backgroundColor = task.categoria.color
        cell.lblDescricao.text = task.nome
        
        return cell
    }
    
    @IBAction func onBtnRemover(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: tableView)
        guard let indexPath = tableView.indexPathForRow(at: point)
        else {return}
        tarefas.remove(at: indexPath.row)
        tableView.beginUpdates()
        tableView.deleteRows(at: [IndexPath(row: indexPath.row, section: 0)], with: .left)
        tableView.endUpdates()
    }
    
    
    
}
