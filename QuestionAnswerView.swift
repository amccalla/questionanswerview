//
//  QuestionAnswerView.swift
//  QuestionAnswerViewSwiftDemo
//
//  Created by Andrew McCalla on 8/24/15.
//

import UIKit

@IBDesignable open class QuestionAnswerView: UIView {
    
    open var plistName: String! {
        didSet {
            let plistPath: NSString = Bundle.main.path(forResource: plistName, ofType: "plist")! as NSString
            questionAnswerArray = NSArray(contentsOfFile: plistPath as String)! as! [Dictionary<String, String>] as [AnyObject]
        }
    }

    @IBInspectable open var questionCellBackgroundColor: UIColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 1.0)
    @IBInspectable open var answerCellBackgroundColor: UIColor = UIColor.white
    @IBInspectable open var questionTextColor: UIColor = UIColor(red: 85.0/255.0, green: 76.0/255.0, blue: 79.0/255.0, alpha: 1.0)
    @IBInspectable open var answerTextColor: UIColor = UIColor(red: 85.0/255.0, green: 76.0/255.0, blue: 79.0/255.0, alpha: 1.0)
    @IBInspectable open var tableViewBackgroundColor: UIColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 1.0)

    @IBInspectable open var allowMultipleExpanded: Bool = true
    @IBInspectable open var renderHTMLAnswers: Bool = false

    open var questionLabelFont: UIFont = UIFont.boldSystemFont(ofSize: 18.0)
    open var answerLabelFont: UIFont = UIFont.systemFont(ofSize: 16.0)

    open var htmlAnswerFontFace: String = "HelveticaNeue"
    open var htmlAnswerFontSize: String = "5"

    var tableView: UITableView!
    var questionAnswerArray = [AnyObject]()
    var expandedSections = Set<Int>()
    
    let kQuestionCellIdentifier = "questionCell"
    let kAnswerCellIdentifier = "answerCell"
    
    override open func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        let firstQuestion = ["question": "First Question", "answer": "First Answer"]
        let secondQuestion = ["question": "Second Question", "answer": "Second Answer"]
        
        questionAnswerArray = [firstQuestion as AnyObject, secondQuestion as AnyObject]
        
        expandedSections.insert(0)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setUp()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        setUp()
    }
    
    func setUp() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44.0
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.tableFooterView = UIView()
        addSubview(tableView)

        tableView.register(UINib(nibName: "AnswerView", bundle: Bundle(for: QuestionAnswerView.self)), forCellReuseIdentifier: kAnswerCellIdentifier)
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        tableView.frame = CGRect(x: 0.0, y: 0.0, width: self.frame.size.width, height: self.frame.size.height)
    }
    
    func setTableViewBackgroundColors(_ tableViewBackgroundColor: UIColor) {
        self.tableViewBackgroundColor = tableViewBackgroundColor
        tableView.backgroundColor = self.tableViewBackgroundColor
    }
    
    func configureQuestionCell(_ cell: UITableViewCell, atIndexPath indexPath: IndexPath) {
        let questionDictionary = questionAnswerArray[indexPath.section]
        
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.font = questionLabelFont
        cell.textLabel?.textColor = questionTextColor
        cell.textLabel?.text = questionDictionary["question"] as? String
        
        cell.backgroundColor = questionCellBackgroundColor
        cell.layoutMargins = UIEdgeInsets.zero
        cell.preservesSuperviewLayoutMargins = false
    }

    func configureAnswerCell(_ cell: AnswerTableViewCell, atIndexPath indexPath: IndexPath) {
        let questionDictionary = questionAnswerArray[indexPath.section] as! [String: String]
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.textView.font = answerLabelFont
        cell.textView.textColor = answerTextColor

        let answer = questionDictionary["answer"]

        if renderHTMLAnswers {
            var htmlText = "<font face=\"\(htmlAnswerFontFace)\" size=\"\(htmlAnswerFontSize)\">"
            htmlText += answer!
            htmlText += "</font>"

            do {
                let attributedString = try NSMutableAttributedString(data: htmlText.data(using: String.Encoding.utf8)!, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)

                if let imageName = questionDictionary["image"] {
                    let imageAttachment = ImageTextAttachment()
                    imageAttachment.image = UIImage(named: imageName)

                    let imageAttributedString = NSAttributedString(attachment: imageAttachment)
                    attributedString.append(imageAttributedString)
                }

                cell.textView.attributedText = attributedString
            } catch {
                cell.textView.text = answer
            }
        } else {
            cell.textView.text = answer
        }

        cell.backgroundColor = answerCellBackgroundColor
        cell.layoutMargins = UIEdgeInsets.zero
        cell.preservesSuperviewLayoutMargins = false
    }
}

// MARK: UITableViewDataSource

extension QuestionAnswerView: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (expandedSections.contains(section)) {
            return 2
        }
        
        return 1
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return questionAnswerArray.count
    }
}

// MARK: UITableViewDelegate

extension QuestionAnswerView: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row == 0) {
            var cell = tableView.dequeueReusableCell(withIdentifier: kQuestionCellIdentifier)
            
            if (cell == nil) {
                cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: kQuestionCellIdentifier)
            }

            configureQuestionCell(cell!, atIndexPath: indexPath)
            
            return cell!
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: kAnswerCellIdentifier, for: indexPath) as! AnswerTableViewCell

            configureAnswerCell(cell, atIndexPath: indexPath)
            
            return cell
        }
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 0) {
            var indexesToReloadSet = IndexSet(integer: indexPath.section)
            
            if (expandedSections.contains(indexPath.section)) {
                expandedSections.remove(indexPath.section)
            } else {
                if (!allowMultipleExpanded) {
                    if (expandedSections.count > 0) {
                        let previousSection = expandedSections.first
                        indexesToReloadSet.insert(previousSection!)
                        expandedSections.removeAll()
                    }
                }
                
                expandedSections.insert(indexPath.section)
            }
            tableView.reloadSections(indexesToReloadSet as IndexSet, with: UITableViewRowAnimation.automatic)
            
            tableView.scrollToRow(at: IndexPath(row: 0, section: indexPath.section), at: UITableViewScrollPosition.top, animated: true)
        }
    }
}
