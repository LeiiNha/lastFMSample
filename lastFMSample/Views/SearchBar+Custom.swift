//
//  SearchBar+Custom.swift
//  lastFMSample
//
//  Created by Erica Geraldes on 01/07/2019.
//  Copyright © 2019 Erica Geraldes. All rights reserved.
//

import UIKit

final class SearchBar: UISearchBar {
    
    init(delegate: UISearchBarDelegate) {
        super.init(frame: CGRect.zero)
        self.delegate = delegate
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        self.placeholder = "Search for an album"
        self.barTintColor = Colors.primary
        self.searchBarStyle = UISearchBar.Style.prominent
        self.isTranslucent = false
    }
}
