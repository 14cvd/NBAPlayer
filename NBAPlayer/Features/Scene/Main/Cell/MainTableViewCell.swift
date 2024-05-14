//
//  MainTableViewCell.swift
//  NBAPlayer
//
//  Created by cavID on 14.05.24.
//

import UIKit
import SnapKit

class MainTableViewCell: UITableViewCell {
    static let id : String = "\(MainTableViewCell.self)"
    private var titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24)
        return label
    }()
    
    
    
    public func fetchData (_ data : Player){
        titleLabel.text = "\(data.firstName)  \(data.lastName)"
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        config()
        configConstraint()
        
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension MainTableViewCell {
    func config(){
        contentView.addSubview(titleLabel)
    }
    func configConstraint() {
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(30)
            make.top.equalTo(50)
            make.bottom.equalToSuperview()
        }
    }
}
