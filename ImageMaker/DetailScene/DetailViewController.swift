//
//  DetailViewController.swift
//  ImageMaker
//
//  Created by 이정민 on 2023/07/30.
//

import UIKit
import SnapKit

class DetailViewController: UIViewController {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Constant.backGroundColor
        configImageView()
    }
    
    init(image: UIImage) {
        super.init(nibName: nil, bundle: nil)
        imageView.image = image
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension DetailViewController {
    func configImageView() {
        self.view.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(self.view.safeAreaLayoutGuide.snp.horizontalEdges)
            make.height.equalTo(imageView.snp.width)
            make.center.equalTo(self.view.safeAreaLayoutGuide.snp.center)
        }
    }
}
