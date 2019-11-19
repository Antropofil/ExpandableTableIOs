//
//  ViewController.swift
//  ExapnableTable
//
//  Created by Denis Hanin on 15/11/2019.
//  Copyright © 2019 Denis Hanin. All rights reserved.
//

import Foundation
import UIKit

class ViewController : UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    @IBOutlet weak var myTableView: UITableView!
    
    let cellId = "MyTableViewCell"
    let headerId = "HeaderFooterView"
        
    
//MARK -Variables
    
    var model: Guarantor = Guarantor()
    
    var redIcon = UIImage() // UIImage(systemName: "redSectionIcon")
    var blueIcon = UIImage() // UIImage(systemName: "buttonIcon")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.tableFooterView = UIView()
        
        self.myTableView.sectionHeaderHeight = UITableView.automaticDimension
        self.myTableView.estimatedSectionHeaderHeight = 60
        self.myTableView.rowHeight = UITableView.automaticDimension
        self.myTableView.estimatedRowHeight = 44.0

        redIcon = UIImage(named: "redSectionIcon")!
        blueIcon = UIImage(named: "buttonIcon")!
        
        model = Guarantor(
            title: "Students",
            sections: [
                section(
                    title: "first grade dfghjnbhg dfmhgjkdfg hahgjkdfhg jahlfhgjklha fjkglhajkfhgal",
                    fields: [field(title: "Samdfghjnbhgdfmhgjkdfghahgjkdfhgjahlfhgjklhafjkglhajkfhgal"), field(title: "Emma")]
                ),
                section(
                    title: "second grade",
                    fields: [field(title: "Jake"), field(title: "Suzan")]
                ),
                section(
                    title: "3d grade",
                    fields: [field(title: "Jake"), field(title: "Suzan")]
                ),
                section(
                    title: "4th grade",
                    fields: [field(title: "Jake"), field(title: "Suzan")]
                )
            ]
        )
        navigationItem.title = model.title
        navigationController?.navigationBar.prefersLargeTitles = true
        //MyTableViewCell
        self.myTableView.register(UINib(nibName: "MyTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
        self.myTableView.register(UINib(nibName: "Header", bundle: nil), forHeaderFooterViewReuseIdentifier: headerId)
        
        myTableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return model.sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.sections[section].isExpanded ? model.sections[section].fields.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! MyTableViewCell
        cell.setupCell(model: self.model.sections[indexPath.section].fields[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerId) as! HeaderFooterView
        
        header.setupHeader(section: self.model.sections[section], sectionNumber: section, delegate: self)
        
        return header
    }
}


//MARK: - HeaderFooterDelegate expandedSection

extension ViewController: HeaderFooterDelegate {
    func handleExpandCloseFooter(headerView: HeaderFooterView) {
        let expandableSectionNumber = headerView.sectionButton!.tag
        let expandedSectionNumber = self.model.sections.firstIndex{$0.isExpanded} ?? -1
        
        if(expandedSectionNumber >= 0 && expandableSectionNumber != expandedSectionNumber) {
            self.model.sections[expandedSectionNumber].isExpanded = false
            self.myTableView.reloadSections([expandedSectionNumber], with: .automatic)
        }
        self.model.sections[expandableSectionNumber].isExpanded = !self.model.sections[expandableSectionNumber].isExpanded
        if(expandedSectionNumber < 0 || expandableSectionNumber == expandedSectionNumber) {
            self.myTableView.reloadSections([expandableSectionNumber], with: .automatic)
            return
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + DispatchTimeInterval.milliseconds(200)) {
            self.myTableView.reloadSections([expandableSectionNumber], with: .automatic)
        }
    }
}

class SectionHandleExpandClose: UITapGestureRecognizer {
    var section: Int = 0
}

