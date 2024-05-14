//
//  ViewController.swift
//  NBAPlayer
//
//  Created by cavID on 14.05.24.
//

import UIKit
import SnapKit

class MainVC: UIViewController {
    
    private lazy var  tableView : UITableView = {
        let tv = UITableView()
        tv.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.id)
        tv.reloadData()
        tv.delegate = self
        tv.dataSource = self
        return tv
        
    }()
    private var item : [Player] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        NetworkManager.shared.fetch { result  in
            switch result {
            case .success(let players):
                self.item = players
                print(self.item)
            case .failure(let failure):
                print("Failure: \(failure)")
            }
        }
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
        cell.fetchData(item[indexPath.row])
        return cell
    }
    
    
}

