//
//  EventDetailViewController.swift
//  EventOverview
//
//  Created by Wottrich on 17/05/20.
//  Copyright © 2020 Wottrich Technology Company. All rights reserved.
//

import UIKit

class EventDetailViewController: BaseViewController {

    var id: String = ""
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    private var refreshControl = UIRefreshControl()
    private let hasGoogleMaps = UIApplication.shared.canOpenURL(URL(string: "comgooglemaps://")!)
    
    private lazy var viewModel: EventDetailViewModel = {
       EventDetailViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Detalhes do evento"
        
        self.loader.hidesWhenStopped = true
        
        self.setupTableView()
        
        self.getData()
    }
    
    @objc private func getData () {
        
        if !self.refreshControl.isRefreshing {
            self.loader.startAnimating()
        }
        
        self.clearTableView()
        
        self.viewModel.getEventById(id: id) { (error) in
            
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
        
        self.tableView.registerXib(type: EventCheckInFooterTableViewCell.self)
        self.tableView.registerXib(type: CouponTableViewCell.self)
        self.tableView.registerXib(type: ConfirmPeopleTableViewCell.self)
        self.tableView.registerXib(type: LinkLabelTableViewCell.self)
        self.tableView.registerXib(type: EventHeaderTableViewCell.self)
        self.tableView.registerXib(type: EventsTableViewCell.self)
        
    }
    
    private func clearTableView() {
        self.viewModel.event = nil
        self.tableView.reloadData()
    }
    
    private func onCheckIn () {
         
        if self.viewModel.event != nil {
            self.navigate.to(self, viewControllerToGo: ConfirmCheckInViewController.self) { (nextViewController) in
                nextViewController?.delegate = self
            }.go(segue: .modal(modalPresentationStyle: .automatic, animated: true, completion: nil))
        }
        
    }
    
    @IBAction func didTapShare(_ sender: Any) {
        
        if let event = self.viewModel.event {
            
            let title = event.title ?? ""
            let description = event.eventDescription ?? ""
            
            let text = "\(title)\n\(description)"
            
            let textToShare = [ text ]
            let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view

            activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]

            self.present(activityViewController, animated: true, completion: nil)
            
        }

    }
    
}

extension EventDetailViewController: ConfirmCheckInViewControllerProtocol {
    
    func confirmCheckIn(name: String, email: String) {
        self.viewModel.checkingInProgress = true
        self.tableView.reloadData()
        self.viewModel.checkIn(name: name, email: email) { (error) in
            
            self.viewModel.checkingInProgress = false
            self.tableView.reloadData()
            
            if let message = error {
                self.alert(error: message)
                return
            }
            
            self.alert(
                message: "Check-in realizado com sucesso.\nAproveite o evento :D",
                style: .alert,
                handlers: [.init(title: "OK", style: .default, handler: nil)]
            )
            
        }
    }
    
}

extension EventDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            
            let enumIndex = EventEntry.allValue[indexPath.row]
            
            guard let event = self.viewModel.event else {
                tableView.deselectRow(at: indexPath, animated: true)
                return
            }
            
            switch enumIndex {
            case .location:
                if let latitude = event.latitude, let longitude = event.longitude {
                    
                    var handlers: [UIAlertAction] = []
                    
                    if self.hasGoogleMaps {
                        handlers.append(.init(title: "Google Maps", style: .default, handler: { _ in
                            self.openGoogleMap(latitude: latitude, longitude: longitude)
                        }))
                    }
                    
                    handlers.append(.init(title: "Apple Map", style: .default, handler: { _ in
                        self.openAppleMap(title: event.title ?? "", latitude: latitude, longitude: longitude)
                    }))
                    
                    self.alert(message: "Escolha uma opção", handlers: handlers)
                    
                } else {
                    self.alert(error: "Não foi possivel concluir a ação")
                }
                break
            case .description:
                if let title = event.title, let description = event.eventDescription {
                    
                    self.alert(title: title, message: description, handlers: [.init(title: "OK", style: .default, handler: nil)])
                    
                }
            default:
                break
            }
            
        } else if indexPath.section == 1 {
            
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            
            switch EventEntry.allValue[indexPath.row] {
            case .confirmPeople:
                return ConfirmPeopleTableViewCell.height
            case .location, .description:
                return LinkLabelTableViewCell.height
            case .header:
                return EventsTableViewCell.height
            }
            
        } else if indexPath.section == 1 {
            return CouponTableViewCell.height
        } else {
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else {
            return EventHeaderTableViewCell.height
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section != 1 {
            return 0
        } else {
            return EventCheckInFooterTableViewCell.height
        }
    }
    
}

extension EventDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        if section != 1 {
            return nil
        }
        
        guard let headerCell = tableView.dequeueReusableCell(withIdentifier: EventCheckInFooterTableViewCell.identifier)
        as? EventCheckInFooterTableViewCell else { return UIView() }
        
        let checking = self.viewModel.checkingInProgress
        
        headerCell.setup(title: checking ? "Checking" : "Check-In", color: checking ? #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1) : #colorLiteral(red: 0, green: 0.09803921569, blue: 0.2784313725, alpha: 1))
        headerCell.onClick = self.onCheckIn
        
        return headerCell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerCell = tableView.dequeueReusableCell(withIdentifier: EventHeaderTableViewCell.identifier)
            as? EventHeaderTableViewCell else { return UIView() }
        
        if section != 1 {
            return nil
        }
        
        let eventIsEmpty = self.viewModel.coupons.isEmpty
        
        headerCell.setup(header: eventIsEmpty ? "Nenhum cupom disponivel." : "Coupons disponiveis")
        
        return headerCell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return self.viewModel.event != nil ? EventEntry.allValue.count : 0
        } else if section == 1 {
            return self.viewModel.coupons.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let eventIndex = EventEntry.allValue[indexPath.row]
            
            guard let event = self.viewModel.event else { return UITableViewCell() }
            
            switch eventIndex {
            case .header:
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: EventsTableViewCell.identifier)
                    as? EventsTableViewCell else { return UITableViewCell() }
                
                cell.setup(event: event, hideArrow: true)
                
                return cell
                
            case .location, .description:
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: LinkLabelTableViewCell.identifier)
                    as? LinkLabelTableViewCell else { return UITableViewCell() }
                
                cell.setup(messageLink: eventIndex == .location ? "Ver endereço" : "Mostrar descrição")
                
                return cell
                
            case .confirmPeople:
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: ConfirmPeopleTableViewCell.identifier)
                as? ConfirmPeopleTableViewCell else { return UITableViewCell() }
                
                cell.setup(peopleCount: "\(event.peopleList.count)")
                
                return cell
                
            }
            
        } else if indexPath.section == 1 {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CouponTableViewCell.identifier)
                as? CouponTableViewCell else { return UITableViewCell() }
            
            let coupon = self.viewModel.coupons[indexPath.row]
            
            cell.setup(coupon: coupon, totalPrice: self.viewModel.event?.price ?? 0.0)
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    
}
