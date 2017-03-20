QuestionAnswerView
===============

QuestionAnswerView is an iOS view used for displaying expandable question and answers within a UITableView. It supports customization for different styling requirements. 

![Demo GIF](http://i.imgur.com/uSYaqR5.gif)

<br/>

### Requirements
QuestionAnswerView works on iOS 8.0 and greater. It requires Xcode 8.0 or greater, as it uses Swift 3.0.

<br/>

### Usage
The question answer view can be added using Interface Builder or programmatically. Here is an example of adding it programmatically:

    let questionAnswerView = QuestionAnswerView(frame: CGRectMake(0.0, 0.0, view.frame.size.width, view.frame.size.height))
    questionAnswerView.plistName = "QuestionAnswers"
    view.addSubview(questionAnswerView)

<br/>
A plist must be included in the project which contains the questions and answers as an array of dictionaries. Each dictionary will contain an entry for key "question" and key "answer". Optionally it can contain an entry for the key "image". Image support requires renderHTMLAnswers to be set to true.

![Plist Sample](http://i.imgur.com/3ssk3P6l.png)

<br/>

### Customization
Set the plist of questions and answers to be loaded.

    plistName: String!

Set the background color of the question cells. Defaults to UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 1.0).

    questionCellBackgroundColor: UIColor!

Set the background color of the answer cells. Defaults to UIColor.whiteColor().

    answerCellBackgroundColor: UIColor!

Set the question text color. Defaults to UIColor(red: 85.0/255.0, green: 76.0/255.0, blue: 79.0/255.0, alpha: 1.0).

    questionTextColor: UIColor!

Set the answer text color. Defaults to UIColor(red: 85.0/255.0, green: 76.0/255.0, blue: 79.0/255.0, alpha: 1.0).

    answerTextColor: UIColor!

Set the background color of the UITableView. Defaults to UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 1.0).

    tableViewBackgroundColor: UIColor!

Set the font of the question label. Defaults to bold system 18.0.

    questionLabelFont: UIFont!

Set the font of the answer label. Defaults to system 16.0.

    answerLabelFont: UIFont!

Set whether or not multiple questions can be expanded at once. Defaults to false.

    allowMultipleExpanded: Bool!

Set whether or not the answer text should be rendered as HTML. Defaults to false.

	renderHTMLAnswers: Bool!

Set the font face of the HTML for answers. Requires renderHTMLAnswers to be true. Defaults to HelveticaNeue.

	htmlAnswerFontFace: String!

Set the font size of the HTML for answers. Requires renderHTMLAnswers to be true. Defaults to 5.

	htmlAnswerFontSize: String!
