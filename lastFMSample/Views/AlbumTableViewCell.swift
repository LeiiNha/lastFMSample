//
//  AlbumTableViewCell.swift
//  lastFMSample
//
//  Created by Erica Geraldes on 01/07/2019.
//  Copyright © 2019 Erica Geraldes. All rights reserved.
//

import UIKit

final class AlbumTableViewCell: UITableViewCell {
    
    var name: String? {
        didSet {
            nameLabel.text = name
        }
    }
    
    var albumImage: UIImage? {
        didSet {
            albumImageView.image = albumImage
        }
    }
    
    private let nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: FontSize.small)
        lbl.textAlignment = .left
        return lbl
    }()
    
    private let albumImageView: UIImageView = {
        return UIImageView(frame: CGRect(x: 0, y: 0, width: 70.0, height: 70.0))
    }()
    
    static var reuseIdentifier: String = "AlbumTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = Colors.terciary.withAlphaComponent(0.3)
        addSubview(nameLabel)
        addSubview(albumImageView)
        setAnchors()
    }
    
    private func setAnchors() {
        albumImageView.translatesAutoresizingMaskIntoConstraints = false
        albumImageView.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor).isActive = true
        albumImageView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                                                 constant: -Spacing.medium).isActive = true
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                                           constant: Spacing.medium).isActive = true
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
