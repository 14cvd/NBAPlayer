//
//  ViewController.swift
//  NBAPlayer
//
//  Created by cavID on 14.05.24.
//

import UIKit
import SnapKit
import Combine


class MainVC: UIViewController {
    private var cancellables = Set<AnyCancellable>()
    
    private lazy var  tableView : UITableView = {
        let tv = UITableView()
        tv.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.id)
        tv.delegate = self
        tv.dataSource = self
        tv.separatorStyle = .none
        return tv
        
    }()
    private var item : [Player] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        NetworkManager.shared.fetch()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Finished fetching players.")
                case .failure(let error):
                    print("Error fetching players: \(error)")
                }
            }, receiveValue: { players in
                // Handle fetched players
                self.item = players
                print("Fetched players: \(players)")
            })
            .store(in: &cancellables)

        
        config()
        configConstraint()
    }
}

private extension MainVC {
    func config(){
        view.addSubview(tableView)
    }
    func configConstraint(){
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
extension MainVC : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return item.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.id, for: indexPath) as? MainTableViewCell else  {
            return UITableViewCell()
        }
        tableView.allowsSelection = false
        cell.fetchData(item[indexPath.row])
        return cell
    }
    
    
}

