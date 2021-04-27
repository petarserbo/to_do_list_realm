//
//  TaskTableViewCell.swift
//  to_do_list_realm
//
//  Created by Petar Perich on 27.04.2021.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    private let identifier = "Cell"
    @IBOutlet weak var taskLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
