//
//  AlbumDetailViewController.swift
//  lastFMSample
//
//  Created by Erica Geraldes on 01/07/2019.
//  Copyright © 2019 Erica Geraldes. All rights reserved.
//

import UIKit

final class AlbumDetailViewController: UIViewController {
    
    let viewModel: AlbumDetailViewModel
    
    private(set) var favoriteAlbums: [Album]?
    
    public init(viewModel: AlbumDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        self.configureSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Colors.primary
    }
}

private extension AlbumDetailViewController {
    
    func configureSubviews() {
        
        self.addLabel()
        self.addLikeButton()
    }
    
    func addLabel() {
        DispatchQueue.main.async {
            
        
        let detailsText: UILabel = UILabel(frame: CGRect.zero)
        detailsText.textAlignment = .left
        detailsText.numberOfLines = 0
        detailsText.font.withSize(FontSize.small)
        detailsText.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(detailsText)
        detailsText.text = self.viewModel.getTextForAlbum()
        detailsText.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        detailsText.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        detailsText.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        detailsText.heightAnchor.constraint(equalToConstant: 200.0).isActive = true
        }
    }
    
    func addLikeButton() {
        let likeBtn = UIButton(type: .custom)
        likeBtn.setImage(self.viewModel.getImageForAlbum(), for: .normal)
        likeBtn.addTarget(self, action: #selector(handleBtnPress(_:)), for: .touchUpInside)
        self.view.addSubview(likeBtn)
        likeBtn.translatesAutoresizingMaskIntoConstraints = false
        likeBtn.heightAnchor.constraint(equalToConstant: 100.0).isActive = true
        likeBtn.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
        likeBtn.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        likeBtn.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor,
                                        constant: -Spacing.xLarge).isActive = true
    }
    
    @objc func handleBtnPress(_ sender: UIButton) {
        self.viewModel.handleBtnPress(sender)
        sender.setImage(self.viewModel.getImageForAlbum(), for: .normal)
    }
}
