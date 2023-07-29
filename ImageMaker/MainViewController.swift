//
//  MainViewController.swift
//  ImageMaker
//
//  Created by 이정민 on 2023/07/29.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    private enum Constant {
        static let backGroundColor: UIColor = UIColor(cgColor: .init(red: 18 / 256,
                                                                     green: 18 / 256,
                                                                     blue: 18 / 256,
                                                                     alpha: 1.0))
        static let textColor: UIColor = .white
    }
    
    private let entireScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    private let entireStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        return stackView
    }()
    
    // MARK: - Prompt Stack
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
    
    private let promptTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.cornerRadius = 8.0
        textView.layer.borderWidth = 1.0
        textView.layer.borderColor = UIColor.lightGray.cgColor
        
        return textView
    }()
    
    // MARK: - Negative Prompt Stack
    
    private let negativePromptStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        
        return stackView
    }()
    
    private let negativePromptLabelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        
        return stackView
    }()
    
    private let negativePromptLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Negative prompt"
        label.textColor = Constant.textColor
        label.font = .boldSystemFont(ofSize: 20)
        
        return label
    }()
    
    private let negativePromptTextCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0 / 256"
        label.textColor = .lightGray
        label.font = .preferredFont(forTextStyle: .caption2)
        
        return label
    }()
    
    private let negativePromptTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.cornerRadius = 8.0
        textView.layer.borderWidth = 1.0
        textView.layer.borderColor = UIColor.lightGray.cgColor
        
        return textView
    }()
    
    // MARK: - Image Quality Stack
    private let imageQualityStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        
        return stackView
    }()
    
    // MARK: - View Life Cycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Constant.backGroundColor
        
        configStackView()
    }
}

private extension MainViewController {
    func configStackView() {
        self.view.addSubview(entireScrollView)
        entireScrollView.addSubview(entireStackView)
        
        self.entireStackView.addArrangedSubview(promptStackView)
        self.entireStackView.addArrangedSubview(negativePromptStackView)
        self.entireStackView.addArrangedSubview(imageQualityStackView)
        configPromptStackView()
        entireScrollView.isDirectionalLockEnabled = true
        entireScrollView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide.snp.edges)
        }
        
        entireStackView.snp.makeConstraints { make in
            make.edges.equalTo(entireScrollView.snp.edges).inset(20)
            make.centerX.equalTo(entireScrollView.snp.centerX)
        }
        
        entireScrollView.contentSize = entireStackView.bounds.size
    }
    
    // MARK: - Prompt setting
    func configPromptStackView() {
        promptStackView.addArrangedSubview(promptLabelStackView)
        promptStackView.addArrangedSubview(promptTextView)
        
        promptStackView.spacing = 10
        
        promptTextView.snp.makeConstraints { make in
            make.height.equalTo(100)
        }
        
        promptLabelStackView.addArrangedSubview(promptLabel)
        promptLabelStackView.addArrangedSubview(UIView())
        promptLabelStackView.addArrangedSubview(promptTextCountLabel)
        
    }
    
    // MARK: - Negative Prompt setting
    func configNegativePromptStackView() {
        negativePromptStackView.addArrangedSubview(negativePromptLabelStackView)
        negativePromptStackView.addArrangedSubview(negativePromptTextView)
        
        negativePromptStackView.spacing = 10
        
        negativePromptTextView.snp.makeConstraints { make in
            make.height.equalTo(100)
        }
        
        negativePromptLabelStackView.addArrangedSubview(negativePromptLabel)
        negativePromptLabelStackView.addArrangedSubview(UIView())
        negativePromptLabelStackView.addArrangedSubview(negativePromptTextCountLabel)
    }
    
    // MARK: - Image Quality Setting
    func configImageQualityStackView() {
        imageQualityStackView.addArrangedSubview(imageQualityLabelStackView)
        imageQualityStackView.addArrangedSubview(imageQualitySlider)
        
        imageQualityStackView.spacing = 10
        
        imageQualityLabelStackView.addArrangedSubview(imageQualityLabel)
        imageQualityLabelStackView.addArrangedSubview(UIView())
        imageQualityLabelStackView.addArrangedSubview(imageQualityCountLabel)
    }
    
}
