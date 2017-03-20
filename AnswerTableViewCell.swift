//
//  AnswerTableViewCell.swift
//  QuestionAnswerViewDemo
//
//  Created by Andrew McCalla on 10/8/15.

//

import UIKit

class AnswerTableViewCell: UITableViewCell {

    @IBOutlet weak var textView: UITextView!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
