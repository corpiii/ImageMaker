//
//  ImageGeneratorViewController.swift
//  ImageMaker
//
//  Created by 이정민 on 2023/07/29.
//

import UIKit

import SnapKit

class ImageGeneratorViewController: UIViewController {
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
    
    private let positivePromptView: PromptView = .init(promptLabelText: "Positive Prompt")
    private let negativePromptView: PromptView = .init(promptLabelText: "Negative Prompt")
    
    private let imageQualitySliderView: ConfigurationSliderView = .init(targetLabelText: "ImageQuality",
                                                                        sliderValue: 70, sliderMinValue: 1,
                                                                        sliderMaxValue: 100,
                                                                        decimalPlaces: 0)
    
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
        stepper.minimumValue = 1
        stepper.maximumValue = 8
        
        return stepper
    }()

    private let noiseRemoveStepsSliderView: ConfigurationSliderView = .init(targetLabelText: "Noise Remove Steps",
                                                                            sliderValue: 25,
                                                                            sliderMinValue: 10,
                                                                            sliderMaxValue: 100,
                                                                            decimalPlaces: 0)
    
    private let noiseRemoveScaleSliderView: ConfigurationSliderView = .init(targetLabelText: "Noise Remove Scale",
                                                                            sliderValue: 5.0,
                                                                            sliderMinValue: 1.0,
                                                                            sliderMaxValue: 20.0,
                                                                            decimalPlaces: 1)
    
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
    private let noiseRemoveStepsByDecoderSliderView: ConfigurationSliderView = .init(targetLabelText: "Noise Remove Steps By Decoder",
                                                                                     sliderValue: 50,
                                                                                     sliderMinValue: 10,
                                                                                     sliderMaxValue: 100,
                                                                                     decimalPlaces: 0)
    
    // MARK: - Noise Remove Scale By Decoder Stack
    private let noiseRemoveScaleByDecoderSliderView: ConfigurationSliderView = .init(targetLabelText: "Noise Remove Scale By Decoder",
                                                                                     sliderValue: 5.0,
                                                                                     sliderMinValue: 1.0,
                                                                                     sliderMaxValue: 20.0,
                                                                                     decimalPlaces: 1)
    
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
        
        configScrollView()
        configStackView()
    }
}

private extension ImageGeneratorViewController {
    // MARK: - ScrollView setting
    func configScrollView() {
        self.view.addSubview(entireScrollView)
        entireScrollView.addSubview(entireStackView)
        entireScrollView.isDirectionalLockEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        entireScrollView.addGestureRecognizer(tapGesture)
        
        entireScrollView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide.snp.edges)
        }
        
        entireScrollView.contentSize = entireStackView.bounds.size
    }
    
    // MARK: - StackView setting
    func configStackView() {
        self.entireStackView.addArrangedSubview(positivePromptView)
        self.entireStackView.addArrangedSubview(negativePromptView)
        self.entireStackView.addArrangedSubview(imageQualitySliderView)
        self.entireStackView.addArrangedSubview(imageCountStackView)
        self.entireStackView.addArrangedSubview(noiseRemoveStepsSliderView)
        self.entireStackView.addArrangedSubview(noiseRemoveScaleSliderView)
        self.entireStackView.addArrangedSubview(decoderSelectStackView)
        self.entireStackView.addArrangedSubview(noiseRemoveStepsByDecoderSliderView)
        self.entireStackView.addArrangedSubview(noiseRemoveScaleByDecoderSliderView)
        self.entireStackView.addArrangedSubview(generateButton)

        positivePromptView.textViewDelegate = self
        negativePromptView.textViewDelegate = self
        
        configImageCountStackView()
        configDecoderSelectStackView()
        configGenerateButton()
        
        entireStackView.snp.makeConstraints { make in
            make.edges.equalTo(entireScrollView.snp.edges).inset(20)
            make.centerX.equalTo(entireScrollView.snp.centerX)
        }
    }
    
    // MARK: - Image Count Setting
    func configImageCountStackView() {
        imageCountStackView.spacing = 10
        
        imageCountStackView.addArrangedSubview(imageCountLabel)
        imageCountStackView.addArrangedSubview(UIView())
        imageCountStackView.addArrangedSubview(imageCountStpperCountLabel)
        imageCountStackView.addArrangedSubview(imageCountStepper)
        
        imageCountStepper.addTarget(self, action: #selector(imageCountStepperValueChanged), for: .valueChanged)
    }
    
    // MARK: - Decoder Select Setting
    func configDecoderSelectStackView() {
        decoderSelectStackView.addArrangedSubview(decoderSelectLabel)
        decoderSelectStackView.addArrangedSubview(UIView())
        decoderSelectStackView.addArrangedSubview(decoderSelectButton)
        
        decoderSelectButton.snp.makeConstraints { make in
            make.width.equalTo(self.view.safeAreaLayoutGuide.snp.width).multipliedBy(0.4)
        }
        
        decoderSelectButton.addTarget(self, action: #selector(decoderSelectButtonTapped), for: .touchUpInside)
    }
    
    func configGenerateButton() {
        generateButton.addTarget(self, action: #selector(generateButtonTapped), for: .touchUpInside)
    }
}

// MARK: - Obj Method
private extension ImageGeneratorViewController {
    // Stepper func
    @objc func imageCountStepperValueChanged(_ sender: UIStepper) {
        let value = Int(sender.value)
        self.imageCountStpperCountLabel.text = "\(value)"
    }
    
    // scrollView tapped
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func generateButtonTapped() {
        let configuration = ImageConfiguration(prompt: positivePromptView.promptText,
                                               negetivePrompt: negativePromptView.promptText,
                                               imageQuality: Int(imageQualitySliderView.sliderValue),
                                               imageCount: Int(imageCountStpperCountLabel.text!)!,
                                               noiseRemoveSteps: Int(noiseRemoveStepsSliderView.sliderValue),
                                               noiseRemoveScale: noiseRemoveScaleSliderView.sliderValue,
                                               decoder: decoderSelectButton.titleLabel!.text!,
                                               noiseRemoveStepsByDecoder: Int(noiseRemoveStepsByDecoderSliderView.sliderValue),
                                               noiseRemoveScaleByDecoder: noiseRemoveScaleByDecoderSliderView.sliderValue)
        
        let albumController = AlbumViewController(imageConfiguration: configuration)
        let navigationController = UINavigationController(rootViewController: albumController)
        present(navigationController, animated: true)
    }
    
    @objc func decoderSelectButtonTapped(_ sender: UIButton) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let ddim = "decoder_ddim_v_prediction"
        let ddpm = "decoder_ddpm_v_prediction"
        
        let ddimAction = UIAlertAction(title: ddim, style: .default) { _ in
            sender.setTitle(ddim, for: .normal)
        }
        let ddpmAction = UIAlertAction(title: ddpm, style: .default) { _ in
            sender.setTitle(ddpm, for: .normal)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(ddimAction)
        alertController.addAction(ddpmAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
}

extension ImageGeneratorViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: text)
        
        let koreanJamoPattern = "^[^ㄱ-ㅎㅏ-ㅣ]*$"
        let range = text.range(of: koreanJamoPattern, options: .regularExpression)
        
        if range == nil {
            return false
        }
        
        if newText.count <= 256 {
            if textView == positivePromptView.promptTextView {
                positivePromptView.setPromptTextCountLabel("\(newText.count) / 256")
            }

            if textView == negativePromptView.promptTextView {
                negativePromptView.setPromptTextCountLabel("\(newText.count) / 256")
            }
            
            return true
        } else {
            return false
        }
    }
}
