//
//  MyTableViewCell.swift
//  ExpTable2
//
//  Created by Denis Hanin on 15/11/2019.
//  Copyright © 2019 Denis Hanin. All rights reserved.
//

import Foundation
import UIKit

class MyTableViewCell : UITableViewCell {


    //MARK: - Oultets
    
    @IBOutlet weak var cellLabel: UILabel!    
    
}


//MARK: - Public methods

extension MyTableViewCell{
    func setupCell(model: field) {
        self.cellLabel.text = model.title
    }
}
