//
//  Section.swift
//  ExpTable2
//
//  Created by Denis Hanin on 18/11/2019.
//  Copyright © 2019 Denis Hanin. All rights reserved.
//

import Foundation

struct section{
    var title: String = ""
    var isExpanded: Bool = false
    var fields = [field]()
    var sections = [section]()
    var image = ""
}
