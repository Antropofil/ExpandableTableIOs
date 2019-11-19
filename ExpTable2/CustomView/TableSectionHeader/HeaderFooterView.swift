//
//  HeaderFooterView.swift
//  ExpTable2
//
//  Created by Denis Hanin on 18/11/2019.
//  Copyright © 2019 Denis Hanin. All rights reserved.
//

import Foundation
import UIKit

class HeaderFooterView : UITableViewHeaderFooterView {
    
    
    //MARK: - Outlets
    
    @IBOutlet weak var sectionLabel: UILabel!
    @IBOutlet weak var sectionButton: UIButton!
    @IBOutlet weak var sectionImage: UIImageView!
    
    
    //MARK: - Variables

    let redIcon = UIImage(named: "redSectionIcon")!
    let blueIcon = UIImage(named: "buttonIcon")!
    weak var delegate: HeaderFooterDelegate?
}

protocol HeaderFooterDelegate: class {
    func handleExpandCloseFooter(headerView: HeaderFooterView)
}


//MARK: - Public methods

extension HeaderFooterView {
    func setupHeader(section: section, sectionNumber: Int, delegate: HeaderFooterDelegate){
        self.delegate = delegate
        sectionLabel.text = section.title
        sectionButton.setTitle("", for: .normal)
        sectionButton.removeTarget(nil, action: nil, for: .allEvents)
        sectionButton.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)
        sectionButton.tag = sectionNumber
        
//        redIcon = UIImage(named: "redSectionIcon")!
//        blueIcon = UIImage(named: "buttonIcon")!
        self.sectionImage.image = section.isExpanded ? redIcon : blueIcon
    }
    
//    func changeImageView(newImage: UIImage) {
//        self.sectionImage.image = newImage
//    }
}


//MARK: - Private methods

private extension HeaderFooterView {
 
    @objc func handleExpandClose() {
        self.delegate?.handleExpandCloseFooter(headerView: self)
    }
    
}
