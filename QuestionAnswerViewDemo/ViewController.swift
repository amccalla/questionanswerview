//
//  ViewController.swift
//  QuestionAnswerViewSwiftDemo
//
//  Created by Andrew McCalla on 8/24/15.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var questionAnswerView: QuestionAnswerView!

    override func viewDidLoad() {
        super.viewDidLoad()

        questionAnswerView.plistName = "QuestionAnswers"
    }
}
