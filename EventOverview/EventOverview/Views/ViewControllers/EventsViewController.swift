//
//  EventsViewController.swift
//  EventOverview
//
//  Created by Wottrich on 17/05/20.
//  Copyright © 2020 Wottrich Technology Company. All rights reserved.
//

import UIKit

class EventsViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    private var refreshControl = UIRefreshControl()
    
    private lazy var viewModel: EventsViewModel = {
        EventsViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loader.hidesWhenStopped = true
        
        self.setupTableView()
        
        self.getData()
        
    }
    
    @objc private func getData() {
        
        if !self.refreshControl.isRefreshing {
            self.loader.startAnimating()
        }
        
        self.clearTableView()
        
        self.viewModel.loadEvents { (error) in
            
            //Stop loaders
            self.loader.stopAnimating()
            self.refreshControl.endRefreshing()
            
            if let message = error {
                self.alert(error: message)
            }
            
            self.tableView.reloadData()
            
        }
        
    }
    
    private func setupTableView () {
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.refreshControl.attributedTitle = NSAttributedString(string: "Puxe para baixo para atualizar")
        self.refreshControl.addTarget(self, action: #selector(getData), for: .valueChanged)
        self.tableView.refreshControl = self.refreshControl
        
        self.tableView.register(
            EventHeaderTableViewCell.loadNib(),
            forCellReuseIdentifier: EventHeaderTableViewCell.identifier
        )
        
        self.tableView.register(
            EventsTableViewCell.loadNib(),
            forCellReuseIdentifier: EventsTableViewCell.identifier
        )
        
    }
    
    private func clearTableView() {
        self.viewModel.events.removeAll()
        self.tableView.reloadData()
    }

}

extension EventsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //let event = self.viewModel.events[indexPath.row]
        //TODO: go to event detail
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return EventsTableViewCell.height
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return EventHeaderTableViewCell.height
    }
    
}

extension EventsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.events.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerCell = tableView.dequeueReusableCell(withIdentifier: EventHeaderTableViewCell.identifier)
            as? EventHeaderTableViewCell else { return UIView() }
        
        let eventIsEmpty = self.viewModel.events.isEmpty
        
        headerCell.setup(header: eventIsEmpty ? "Nenhum evento disponivel." : "Aqui estão alguns eventos.")
        
        return headerCell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EventsTableViewCell.identifier)
            as? EventsTableViewCell else { return UITableViewCell() }
        
        let event = self.viewModel.events[indexPath.row]
        cell.setup(event: event)
        
        return cell
    }
    
    
}
