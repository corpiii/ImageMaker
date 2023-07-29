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
    
    private let imageQualityLabelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        
        return stackView
    }()
    
    private let imageQualityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Image Quality"
        label.textColor = Constant.textColor
        label.font = .boldSystemFont(ofSize: 20)
        
        return label
    }()
    
    private let imageQualityCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Constant.textColor
        label.text = "70"
        
        return label
    }()
    
    private let imageQualitySlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 1
        slider.maximumValue = 100
        slider.value = 70
        
        return slider
    }()
    
    // MARK: - Image Count Stack
    private let imageCountStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        
        return stackView
    }()
    
    private let imageCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Image Count"
        label.textColor = Constant.textColor
        label.font = .boldSystemFont(ofSize: 20)
        
        return label
    }()
    
    private let imageCountStpperCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "1"
        label.textColor = Constant.textColor
        
        return label
    }()
    
    private let imageCountStepper: UIStepper = {
        let stepper = UIStepper()
        stepper.translatesAutoresizingMaskIntoConstraints = false
        stepper.backgroundColor = Constant.textColor
        
        return stepper
    }()

    
    // MARK: - Image Noise Remove Steps Stack
    private let noiseRemoveStepsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        
        return stackView
    }()
    
    private let noiseRemoveStepsLabelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        
        return stackView
    }()
    
    private let noiseRemoveStepsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = Constant.textColor
        label.text = "Noise Remove Steps"
        
        return label
    }()
    
    private let noiseRemoveStepsCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Constant.textColor
        label.text = "25"
        
        return label
    }()
    
    private let noiseRemoveStepsSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 10
        slider.maximumValue = 100
        slider.value = 25
        
        return slider
    }()
    
    // MARK: - Image Noise Remove Scale Stack
    private let noiseRemoveScaleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        
        return stackView
    }()
        
    private let noiseRemoveScaleLabelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        
        return stackView
    }()
    
    private let noiseRemoveScaleCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Constant.textColor
        label.text = "5.0"
        
        return label
    }()
    
    private let noiseRemoveScaleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = Constant.textColor
        label.text = "Noise Remove Scale"
        
        return label
    }()
    
    private let noiseRemoveScaleSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 1.0
        slider.maximumValue = 20.0
        slider.value = 5.0
        
        return slider
    }()
    
    // MARK: - Decoder Select Stack
    private let decoderSelectStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        
        return stackView
    }()
    
    private let decoderSelectLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = Constant.textColor
        label.text = "Decoder"
        
        return label
    }()
    
    private let decoderSelectButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("decoder_ddim_v_prediction", for: .normal)
        button.titleLabel?.lineBreakMode = .byTruncatingTail
        
        return button
    }()
    
    // MARK: - Noise Remove Steps By Decoder Stack
    private let noiseRemoveStepsByDecoderStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        
        return stackView
    }()
    
    private let noiseRemoveStepsByDecoderLabelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        
        return stackView
    }()
    
    private let noiseRemoveStepsByDecoderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Noise Remove Steps By Decoder"
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = Constant.textColor
        
        return label
    }()
    
    private let noiseRemoveStepsByDecoderCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "50"
        label.textColor = Constant.textColor
        
        return label
    }()
    
    private let noiseRemoveStepsByDecoderSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 10
        slider.maximumValue = 100
        slider.value = 50
        
        return slider
    }()
    
    // MARK: - Noise Remove Scale By Decoder Stack
    private let noiseRemoveScaleByDecoderStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        
        return stackView
    }()
    
    private let noiseRemoveScaleByDecoderLabelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        
        return stackView
    }()
    
    private let noiseRemoveScaleByDecoderCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "5.0"
        label.textColor = Constant.textColor
        
        return label
    }()
    
    private let noiseRemoveScaleByDecoderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Noise Remove Scale By Decoder"
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = Constant.textColor
        
        return label
    }()
    
    private let noiseRemoveScaleByDecoderSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 1.0
        slider.maximumValue = 20.0
        slider.value = 5.0
        
        return slider
    }()
    
    // MARK: - Generate Button
    private let generateButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Generate", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 24)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        
        return button
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
        self.entireStackView.addArrangedSubview(imageCountStackView)
        self.entireStackView.addArrangedSubview(noiseRemoveStepsStackView)
        self.entireStackView.addArrangedSubview(noiseRemoveScaleStackView)
        self.entireStackView.addArrangedSubview(decoderSelectStackView)
        self.entireStackView.addArrangedSubview(noiseRemoveStepsByDecoderStackView)
        self.entireStackView.addArrangedSubview(noiseRemoveScaleByDecoderStackView)
        self.entireStackView.addArrangedSubview(generateButton)

        configPromptStackView()
        configNegativePromptStackView()
        
        configImageQualityStackView()
        configImageCountStackView()
        
        configNoiseRemoveStepsStackView()
        configNoiseRemoveScaleStackView()
        
        configDecoderSelectStackView()
        
        configNoiseRemoveStepsByDecoderStackView()
        configNoiseRemoveScaleByDecoderStackView()
        
        configGenerateButton()
        
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
    
    // MARK: - Image Count Setting
    func configImageCountStackView() {
        imageCountStackView.spacing = 10
        
        imageCountStackView.addArrangedSubview(imageCountLabel)
        imageCountStackView.addArrangedSubview(UIView())
        imageCountStackView.addArrangedSubview(imageCountStpperCountLabel)
        imageCountStackView.addArrangedSubview(imageCountStepper)
    }
    
    // MARK: - Noise Remove Steps Setting
    func configNoiseRemoveStepsStackView() {
        noiseRemoveStepsStackView.addArrangedSubview(noiseRemoveStepsLabelStackView)
        noiseRemoveStepsStackView.addArrangedSubview(noiseRemoveStepsSlider)
        
        noiseRemoveStepsStackView.spacing = 10
        
        noiseRemoveStepsLabelStackView.addArrangedSubview(noiseRemoveStepsLabel)
        noiseRemoveStepsLabelStackView.addArrangedSubview(UIView())
        noiseRemoveStepsLabelStackView.addArrangedSubview(noiseRemoveStepsCountLabel)
    }
    
    // MARK: - Noise Remove Scale Setting
    func configNoiseRemoveScaleStackView() {
        noiseRemoveScaleStackView.addArrangedSubview(noiseRemoveScaleLabelStackView)
        noiseRemoveScaleStackView.addArrangedSubview(noiseRemoveScaleSlider)
        
        noiseRemoveScaleStackView.spacing = 10
        
        noiseRemoveScaleLabelStackView.addArrangedSubview(noiseRemoveScaleLabel)
        noiseRemoveScaleLabelStackView.addArrangedSubview(UIView())
        noiseRemoveScaleLabelStackView.addArrangedSubview(noiseRemoveScaleCountLabel)
    }
    
    // MARK: - Decoder Select Setting
    func configDecoderSelectStackView() {
        decoderSelectStackView.addArrangedSubview(decoderSelectLabel)
        decoderSelectStackView.addArrangedSubview(UIView())
        decoderSelectStackView.addArrangedSubview(decoderSelectButton)
        
        decoderSelectButton.snp.makeConstraints { make in
            make.width.equalTo(self.view.safeAreaLayoutGuide.snp.width).multipliedBy(0.4)
        }
    }
    
    // MARK: - Noise Remove Steps By Decoder Setting
    func configNoiseRemoveStepsByDecoderStackView() {
        noiseRemoveStepsByDecoderStackView.addArrangedSubview(noiseRemoveStepsByDecoderLabelStackView)
        noiseRemoveStepsByDecoderStackView.addArrangedSubview(noiseRemoveStepsByDecoderSlider)
        
        noiseRemoveStepsByDecoderStackView.spacing = 10
        
        noiseRemoveStepsByDecoderLabelStackView.addArrangedSubview(noiseRemoveStepsByDecoderLabel)
        noiseRemoveStepsByDecoderLabelStackView.addArrangedSubview(UIView())
        noiseRemoveStepsByDecoderLabelStackView.addArrangedSubview(noiseRemoveStepsByDecoderCountLabel)
        
    }
    
    // MARK: - Noise Remove Scale By Decoder Setting
    func configNoiseRemoveScaleByDecoderStackView() {
        noiseRemoveScaleByDecoderStackView.addArrangedSubview(noiseRemoveScaleByDecoderLabelStackView)
        noiseRemoveScaleByDecoderStackView.addArrangedSubview(noiseRemoveScaleByDecoderSlider)
        
        noiseRemoveScaleByDecoderStackView.spacing = 10
        
        noiseRemoveScaleByDecoderLabelStackView.addArrangedSubview(noiseRemoveScaleByDecoderLabel)
        noiseRemoveScaleByDecoderLabelStackView.addArrangedSubview(UIView())
        noiseRemoveScaleByDecoderLabelStackView.addArrangedSubview(noiseRemoveScaleByDecoderCountLabel)
    }
    
    func configGenerateButton() {
        
    }
}

