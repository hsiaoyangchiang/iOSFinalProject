//
//  PaddingUITextView.swift
//  finalProject
//
//  Created by 江曉陽 on 2021/6/12.
//

import UIKit

class PaddingUITextView: UITextView {
      required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        textContainerInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
      }
        

    }

