//
//  AnswerButton.swift
//  study_english
//
//  Created by takumitokiwa on 2021/09/23.
//

import UIKit
import RxSwift
import RxCocoa

@IBDesignable
class AnswerButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setDefaultDesign()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setDefaultDesign()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setDefaultDesign()
    }
    
    private func setDefaultDesign() {
        layer.masksToBounds = true
        layer.cornerRadius = 25.0
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.blue.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = .init(width: 5, height: 5)
        backgroundColor = .white
        titleLabel?.font = .boldSystemFont(ofSize: 14.0)
        titleLabel?.textColor = .blue
        setTitle("", for: .normal)
    }
}
