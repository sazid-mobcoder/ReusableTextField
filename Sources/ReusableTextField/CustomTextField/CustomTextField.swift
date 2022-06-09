//
//  CustomTextField.swift
//  PBWorldUser
//
//  Created by Sazid Iqabal on 17/11/21.
//

import UIKit

public class CustomTextField: UIView {
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var btnSecureTextEntry: UIButton!
    @IBOutlet weak var textField: CustomUITextField!
        
    private lazy var cornerRadius: CGFloat = 5
    private lazy var placeHolderText: String = "Enter Here"
    private lazy var textColor: UIColor = .black
    private lazy var textFont: UIFont? = UIFont.systemFont(ofSize: 14)
    private lazy var bgColor: UIColor = UIColor.white
    private lazy var textBorderColor: UIColor = UIColor.lightGray
    private lazy var textBorderWidth: CGFloat = 1
    private lazy var isSecureEntry: Bool = false
    private lazy var keyboardType: UIKeyboardType = .default
    
    var changeInTextField: ((String)-> Void)?
    
    @discardableResult
    public func configure(text: String = "",
                   placeHolderText: String = "Enter Here",
                   textColor: UIColor = .black,
                   cornerRadius: CGFloat = 5,
                   textFont: UIFont = UIFont.systemFont(ofSize: 14),
                   bgColor: UIColor = .white,
                   textBorderColor: UIColor = .lightGray,
                   textBorderWidth: CGFloat = 1,
                   isSecureEntry: Bool = false,
                   keyboardType: UIKeyboardType = .default) -> CustomTextField {
        self.placeHolderText = placeHolderText
        self.textColor = textColor
        self.cornerRadius = cornerRadius
        self.textFont = textFont
        self.bgColor = bgColor
        self.textBorderColor = textBorderColor
        self.textBorderWidth = textBorderWidth
        self.isSecureEntry = isSecureEntry
        self.text = text
        self.keyboardType = keyboardType
        self.updateViewValues()
//        self.textField.delegate = self
//        self.textField.setEditActions(only: [.copy, .cut, .paste])
        return self
    }
    
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        createViews()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createViews()
    }
    
    private func createViews() {
        Bundle.main.loadNibNamed("CustomTextField", owner: self, options: nil)
        addSubview(self.contentView)
        self.contentView.frame = self.bounds
        self.contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.backgroundColor = .clear
        updateViewValues()
    }
    
    private func updateViewValues() {
        self.contentView.backgroundColor = bgColor
        self.textField.placeholder = self.placeHolderText
        self.textField.textColor = textColor
        self.contentView.layer.cornerRadius = cornerRadius
        self.contentView.layer.borderWidth = textBorderWidth
        self.contentView.layer.borderColor = textBorderColor.cgColor
        self.textField.text = text
        self.textField.isSecureTextEntry = self.isSecureEntry
        self.textField.keyboardType = self.keyboardType
        btnSecureTextEntry.isHidden = !self.isSecureEntry
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    @IBAction func changeEditing(_ sender: UITextField) {
        self.changeInTextField?(sender.text ?? "")
    }
    
    @IBAction func actionSecureTextEntry(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        textField.isSecureTextEntry = !sender.isSelected
    }
    
    
    public func updateText(_ str: String) {
        self.textField.text = str
    }
    
    public var text: String {
        get { return (textField.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines) }
        set {
            textField.text = newValue
        }
    }
}

import Foundation
import UIKit

class CustomUITextField: UITextField {
   override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(UIResponderStandardEditActions.paste(_:)) {
            return false
        }
        return super.canPerformAction(action, withSender: sender)
   }
}
