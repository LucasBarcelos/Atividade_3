//
//  ListaTableViewController.swift
//  atividade-3
//
//  Created by Lucas Barcelos on 11/01/22.
//

import UIKit
import CoreData

class ListaTableViewController: UITableViewController {

    // MARK: - Properties
    var fetchedResultsController: NSFetchedResultsController<Problema>!
    var currentDateTime = Date()
    let formatter = DateFormatter()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        carregarProblemas()
    }

    // MARK: - Methods - Table View
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.fetchedObjects?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let item = fetchedResultsController.object(at: indexPath)
        
        cell.textLabel?.text = item.nome
        cell.detailTextLabel?.text = configHoraData()
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let problema = fetchedResultsController.object(at: indexPath)
            context.delete(problema)
            try? context.save()
        }
    }
    
    // MARK: - Methods
    func carregarProblemas() {
        let fetchRequest: NSFetchRequest<Problema> = Problema.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "nome", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedResultsController.delegate = self
        
        try? fetchedResultsController.performFetch()
    }
    
    func configHoraData() -> String {
        formatter.timeStyle = .short
        formatter.dateStyle = .short
        return formatter.string(from: currentDateTime)
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
}

extension ListaTableViewController: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        tableView.reloadData()
        
    }
}
