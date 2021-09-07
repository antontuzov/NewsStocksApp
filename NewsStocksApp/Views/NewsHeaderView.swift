//
//  NewsHeaderView.swift
//  NewsStocksApp
//
//  Created by Anton Tuzov on 20.08.2021.
//

import UIKit




protocol NewsHeaderViewDelegate: AnyObject {
    func NewsHeaderViewDidTapAddButton(_ headerView: NewsHeaderView)
   
}


class NewsHeaderView: UITableViewHeaderFooterView {
    
    static let identifier = "NewsHeaderView"
    static let prefereHeight: CGFloat = 70
    
    weak var delegate: NewsHeaderViewDelegate?
    
    struct ViewModel {
        let title: String
        let showAddButton: Bool
       
    }
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 32)
        
        
        return label
        
    }()
    
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("+ Watchlist", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
        
    }()
    
    
    
    // MARK: - Init
    
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.addSubviews(label, button)
        contentView.backgroundColor = .secondarySystemBackground
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc private func didTapButton() {
        
        delegate?.NewsHeaderViewDidTapAddButton(self)
        
    }
    
    
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = CGRect(x: 14, y: 0, width: contentView.width-28, height: contentView.height)
        button.sizeToFit()
        button.frame = CGRect(x: contentView.width - button.width - 14,
                              y: (contentView.height - button.height)/2,
                              width: button.width + 8 ,
                              height: button.height)
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
    }
    
    
    public func configure(with viewModel: ViewModel) {
        label.text = viewModel.title
        button.isHidden = !viewModel.showAddButton
        
        
    }
    
 
    
    
    
    
    
    
    
    
}
