//
//  NewsStoryTableViewCell.swift
//  NewsStocksApp
//
//  Created by Anton Tuzov on 20.08.2021.
//

import UIKit
import SDWebImage




class NewsStoryTableViewCell: UITableViewCell {
      static let identifier = "NewsStoryTableViewCell"
    
    
    static let prefHeight: CGFloat = 140
    
    
    struct viewModel {
        let source: String
        let headline:String
        let dataString:String
        let imageUrl: URL?
        
        init(model: NewsStory) {
            self.source = model.source
            self.headline = model.headline
            self.dataString = .string(from: model.datetime)
            self.imageUrl = URL(string: model.image)
            
        }
        
    }
    
    lazy var sourceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        return label
    }()
    
    lazy var headLineLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.numberOfLines = 3
        return label
    }()
    
    
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 12, weight: .light)
        return label
    }()
    
    lazy var storyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .tertiarySystemBackground
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .secondarySystemBackground
        backgroundColor = .secondarySystemBackground
        addSubviews(sourceLabel,dateLabel,headLineLabel,storyImageView  )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageSize: CGFloat = contentView.height/1.2
        storyImageView.frame = CGRect(
            x: contentView.width - imageSize-10,
            y: (contentView.height - imageSize) - 2,
            width: imageSize,
            height: imageSize)
        
        
        let avalibalWidth: CGFloat = contentView.width - separatorInset.left - imageSize - 15
        
        dateLabel.frame = CGRect(
            x: separatorInset.left,
            y: contentView.height - 40,
            width: avalibalWidth,
            height: 40)
        
        
        
        sourceLabel.sizeToFit()
        sourceLabel.frame = CGRect(
            x: separatorInset.left,
            y: 4,
            width: avalibalWidth,
            height: sourceLabel.height)
        headLineLabel.frame = CGRect(
            x: separatorInset.left,
            y: sourceLabel.bottom + 2 ,
            width: avalibalWidth,
            height: contentView.height - sourceLabel.bottom - dateLabel.height - 5)
        
        
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        sourceLabel.text = nil
        dateLabel.text = nil
        headLineLabel.text = nil
        storyImageView.image = nil
    }
    
    public func configure(with viewModel: viewModel ) {
        headLineLabel.text = viewModel.headline
        sourceLabel.text = viewModel.source
        dateLabel.text = viewModel.dataString
        storyImageView.sd_setImage(with: viewModel.imageUrl, completed: nil)
        
        
        
//        set image
//        storyImageView.setImage(with: viewModel.imageUrl)
        
    }
    
    
    
}
