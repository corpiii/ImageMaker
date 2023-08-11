//
//  ConfigurationSliderView.swift
//  ImageMaker
//
//  Created by 이정민 on 2023/08/11.
//

import UIKit

import SnapKit

class ConfigurationSliderView: UIView {
    private let SliderStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        
        return stackView
    }()
    
    private let ConfigurationLabelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        
        return stackView
    }()
    
    private let targetLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Constant.textColor
        label.font = .boldSystemFont(ofSize: 20)
        
        return label
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Constant.textColor
        
        return label
    }()
    
    private let configurationSlider: UISlider = {
        let slider = UISlider()
        
        return slider
    }()
    
    private let decimalPlaces: Int
    
    init(targetLabelText: String, sliderValue: Float, sliderMinValue: Float, sliderMaxValue: Float, decimalPlaces: Int) {
        self.decimalPlaces = decimalPlaces
        super.init(frame: .zero)
        
        configureView()
        
        targetLabel.text = targetLabelText
        configurationSlider.minimumValue = sliderMinValue
        configurationSlider.maximumValue = sliderMaxValue
        configurationSlider.value = sliderValue
        
        setValueLabel(value: sliderValue)
        
        configurationSlider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var sliderValue: Double {
        Double(valueLabel.text!)!
    }
}

private extension ConfigurationSliderView {
    func configureView() {
        SliderStackView.addArrangedSubview(ConfigurationLabelStackView)
        SliderStackView.addArrangedSubview(configurationSlider)
        
        SliderStackView.spacing = 10
        
        ConfigurationLabelStackView.addArrangedSubview(targetLabel)
        ConfigurationLabelStackView.addArrangedSubview(UIView())
        ConfigurationLabelStackView.addArrangedSubview(valueLabel)
        
        addSubview(SliderStackView)
        
        SliderStackView.snp.makeConstraints { make in
            make.edges.equalTo(self.snp.edges)
        }
    }
    
    func setValueLabel(value: Float) {
        valueLabel.text = String(format: "%.\(self.decimalPlaces)f", value)
    }
}

private extension ConfigurationSliderView {
    @objc func sliderValueChanged(_ sender: UISlider) {
        let value = sender.value
        setValueLabel(value: value)
    }
}
