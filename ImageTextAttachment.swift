//
//  ImageTextAttachment.swift
//  QuestionAnswerViewDemo
//
//  Created by Andrew McCalla on 10/19/15.

//

import UIKit

class ImageTextAttachment: NSTextAttachment {

    override func attachmentBounds(for textContainer: NSTextContainer?, proposedLineFragment lineFrag: CGRect, glyphPosition position: CGPoint, characterIndex charIndex: Int) -> CGRect {

        //-16.0 to account for 8.0 padding on left and right
        //
        let width = lineFrag.size.width - 16.0

        let imageSize = image!.size
        let scale = width / imageSize.width

        return CGRect(x: 0.0, y: 0.0, width: imageSize.width * scale, height: imageSize.height * scale)
    }
}
