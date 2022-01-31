//
//  RepositorioTarefas.swift
//  AppAgenda
//
//  Created by dcoxi on 1/30/22.
//

import Foundation

class RepositorioTarefa {
    static let instance: RepositorioTarefa = RepositorioTarefa()
    
    private var tarefas: [Task]
    
    private init() {
        self.tarefas = []
    }
    
    func salvar(tarefa: Task){
        self.tarefas.append(tarefa)
    }
    
    func actualizar(tarefaActualizar: Task){
       let taskIndex = tarefas.firstIndex { (tarefa) -> Bool in
           tarefa.id == tarefaActualizar.id
       }
       tarefas.remove(at: taskIndex!)
       tarefas.append(tarefaActualizar)
        
    }
    
    func getTarefas() -> [Task] {
        self.tarefas
    }
    
}
