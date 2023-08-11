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
    
    // MARK: - Prompt Stack
    private let positivePromptView: PromptView = .init(promptLabelString: "Positive Prompt")
    private let negativePromptView: PromptView = .init(promptLabelString: "Negative Prompt")
    
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
        stepper.minimumValue = 1
        stepper.maximumValue = 8
        
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
        
        self.entireStackView.addArrangedSubview(imageQualityStackView)
        self.entireStackView.addArrangedSubview(imageCountStackView)
        self.entireStackView.addArrangedSubview(noiseRemoveStepsStackView)
        self.entireStackView.addArrangedSubview(noiseRemoveScaleStackView)
        self.entireStackView.addArrangedSubview(decoderSelectStackView)
        self.entireStackView.addArrangedSubview(noiseRemoveStepsByDecoderStackView)
        self.entireStackView.addArrangedSubview(noiseRemoveScaleByDecoderStackView)
        self.entireStackView.addArrangedSubview(generateButton)

        positivePromptView.textViewDelegate = self
        negativePromptView.textViewDelegate = self
        
        configImageQualityStackView()
        configImageCountStackView()
        
        configNoiseRemoveStepsStackView()
        configNoiseRemoveScaleStackView()
        
        configDecoderSelectStackView()
        
        configNoiseRemoveStepsByDecoderStackView()
        configNoiseRemoveScaleByDecoderStackView()
        
        configGenerateButton()
        
        entireStackView.snp.makeConstraints { make in
            make.edges.equalTo(entireScrollView.snp.edges).inset(20)
            make.centerX.equalTo(entireScrollView.snp.centerX)
        }
    }
    
    // MARK: - Image Quality Setting
    func configImageQualityStackView() {
        imageQualityStackView.addArrangedSubview(imageQualityLabelStackView)
        imageQualityStackView.addArrangedSubview(imageQualitySlider)
        
        imageQualityStackView.spacing = 10
        
        imageQualityLabelStackView.addArrangedSubview(imageQualityLabel)
        imageQualityLabelStackView.addArrangedSubview(UIView())
        imageQualityLabelStackView.addArrangedSubview(imageQualityCountLabel)
        
        imageQualitySlider.addTarget(self, action: #selector(imageQualitySliderValueChanged), for: .valueChanged)
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
    
    // MARK: - Noise Remove Steps Setting
    func configNoiseRemoveStepsStackView() {
        noiseRemoveStepsStackView.addArrangedSubview(noiseRemoveStepsLabelStackView)
        noiseRemoveStepsStackView.addArrangedSubview(noiseRemoveStepsSlider)
        
        noiseRemoveStepsStackView.spacing = 10
        
        noiseRemoveStepsLabelStackView.addArrangedSubview(noiseRemoveStepsLabel)
        noiseRemoveStepsLabelStackView.addArrangedSubview(UIView())
        noiseRemoveStepsLabelStackView.addArrangedSubview(noiseRemoveStepsCountLabel)
        
        noiseRemoveStepsSlider.addTarget(self, action: #selector(noiseStepsSliderValueChanged), for: .valueChanged)
    }
    
    // MARK: - Noise Remove Scale Setting
    func configNoiseRemoveScaleStackView() {
        noiseRemoveScaleStackView.addArrangedSubview(noiseRemoveScaleLabelStackView)
        noiseRemoveScaleStackView.addArrangedSubview(noiseRemoveScaleSlider)
        
        noiseRemoveScaleStackView.spacing = 10
        
        noiseRemoveScaleLabelStackView.addArrangedSubview(noiseRemoveScaleLabel)
        noiseRemoveScaleLabelStackView.addArrangedSubview(UIView())
        noiseRemoveScaleLabelStackView.addArrangedSubview(noiseRemoveScaleCountLabel)
        
        noiseRemoveScaleSlider.addTarget(self, action: #selector(noiseScaleSliderValueChanged), for: .valueChanged)
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
    
    // MARK: - Noise Remove Steps By Decoder Setting
    func configNoiseRemoveStepsByDecoderStackView() {
        noiseRemoveStepsByDecoderStackView.addArrangedSubview(noiseRemoveStepsByDecoderLabelStackView)
        noiseRemoveStepsByDecoderStackView.addArrangedSubview(noiseRemoveStepsByDecoderSlider)
        
        noiseRemoveStepsByDecoderStackView.spacing = 10
        
        noiseRemoveStepsByDecoderLabelStackView.addArrangedSubview(noiseRemoveStepsByDecoderLabel)
        noiseRemoveStepsByDecoderLabelStackView.addArrangedSubview(UIView())
        noiseRemoveStepsByDecoderLabelStackView.addArrangedSubview(noiseRemoveStepsByDecoderCountLabel)
        
        noiseRemoveStepsByDecoderSlider.addTarget(self, action: #selector(noiseStepsByDecoderSliderValueChanged), for: .valueChanged)
    }
    
    // MARK: - Noise Remove Scale By Decoder Setting
    func configNoiseRemoveScaleByDecoderStackView() {
        noiseRemoveScaleByDecoderStackView.addArrangedSubview(noiseRemoveScaleByDecoderLabelStackView)
        noiseRemoveScaleByDecoderStackView.addArrangedSubview(noiseRemoveScaleByDecoderSlider)
        
        noiseRemoveScaleByDecoderStackView.spacing = 10
        
        noiseRemoveScaleByDecoderLabelStackView.addArrangedSubview(noiseRemoveScaleByDecoderLabel)
        noiseRemoveScaleByDecoderLabelStackView.addArrangedSubview(UIView())
        noiseRemoveScaleByDecoderLabelStackView.addArrangedSubview(noiseRemoveScaleByDecoderCountLabel)
        
        noiseRemoveScaleByDecoderSlider.addTarget(self, action: #selector(noiseScaleByDecodeSliderValueChanged), for: .valueChanged)
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
    
    // Slider func
    @objc func imageQualitySliderValueChanged(_ sender: UISlider) {
        let value = Int(sender.value)
        self.imageQualityCountLabel.text = "\(value)"
    }
    
    @objc func noiseStepsSliderValueChanged(_ sender: UISlider) {
        let value = Int(sender.value)
        self.noiseRemoveStepsCountLabel.text = "\(value)"
    }
    
    @objc func noiseScaleSliderValueChanged(_ sender: UISlider) {
        let value = String(format: "%.1f", sender.value)
        self.noiseRemoveScaleCountLabel.text = "\(value)"
    }
    
    @objc func noiseStepsByDecoderSliderValueChanged(_ sender: UISlider) {
        let value = Int(sender.value)
        self.noiseRemoveStepsByDecoderCountLabel.text = "\(value)"
    }
    
    @objc func noiseScaleByDecodeSliderValueChanged(_ sender: UISlider) {
        let value = String(format: "%.1f", sender.value)
        self.noiseRemoveScaleByDecoderCountLabel.text = "\(value)"
    }
    
    // scrollView tapped
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func generateButtonTapped() {
        let configuration = ImageConfiguration(prompt: positivePromptView.promptText,
                                               negetivePrompt: negativePromptView.promptText,
                                               imageQuality: Int(imageQualityCountLabel.text!)!,
                                               imageCount: Int(imageCountStpperCountLabel.text!)!,
                                               noiseRemoveSteps: Int(noiseRemoveStepsCountLabel.text!)!,
                                               noiseRemoveScale: Double(noiseRemoveScaleCountLabel.text!)!,
                                               decoder: decoderSelectButton.titleLabel!.text!,
                                               noiseRemoveStepsByDecoder: Int(noiseRemoveStepsByDecoderCountLabel.text!)!,
                                               noiseRemoveScaleByDecoder: Double(noiseRemoveScaleByDecoderCountLabel.text!)!)
        
        let albumController = AlbumViewController(imageConfiguration: configuration)
        let navigationController = UINavigationController(rootViewController: albumController)
        present(navigationController, animated: true)
    }
    
    @objc func decoderSelectButtonTapped(_ sender: UIButton) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let ddimAction = UIAlertAction(title: "decoder_ddim_v_prediction", style: .default) { _ in
            sender.setTitle("decoder_ddim_v_prediction", for: .normal)
        }
        let ddpmAction = UIAlertAction(title: "decoder_ddpm_v_prediction", style: .default) { _ in
            sender.setTitle("decoder_ddpm_v_prediction", for: .normal)
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
