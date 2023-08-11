//
//  PromptView.swift
//  ImageMaker
//
//  Created by 이정민 on 2023/08/11.
//

import UIKit

import SnapKit

class PromptView: UIView {
    weak var textViewDelegate: UITextViewDelegate? {
        didSet {
            promptTextView.delegate = textViewDelegate
        }
    }
    
    private let promptStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        
        return stackView
    }()
    
    private let promptLabelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        
        return stackView
    }()
    
    private let promptLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Prompt"
        label.textColor = Constant.textColor
        label.font = .boldSystemFont(ofSize: 20)
        
        return label
    }()
    
    private let promptTextCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0 / 256"
        label.textColor = .lightGray
        label.font = .preferredFont(forTextStyle: .caption2)
        
        return label
    }()
    
    let promptTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.cornerRadius = 8.0
        textView.layer.borderWidth = 1.0
        textView.layer.borderColor = UIColor.lightGray.cgColor
        
        return textView
    }()
    
    init(promptLabelText: String) {
        super.init(frame: .zero)
        
        promptLabel.text = promptLabelText
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var promptText: String {
        promptTextView.text
    }
    
    func setPromptTextCountLabel(_ text: String) {
        self.promptTextCountLabel.text = text
    }
}

private extension PromptView {
    func configureView() {
        promptStackView.addArrangedSubview(promptLabelStackView)
        promptStackView.addArrangedSubview(promptTextView)
        promptLabelStackView.addArrangedSubview(promptLabel)
        promptLabelStackView.addArrangedSubview(UIView())
        promptLabelStackView.addArrangedSubview(promptTextCountLabel)
        addSubview(promptStackView)
        
        promptStackView.spacing = 10
        
        promptTextView.snp.makeConstraints { make in
            make.height.equalTo(100)
        }
        
        promptStackView.snp.makeConstraints { make in
            make.edges.equalTo(self.snp.edges)
        }
    }
}
