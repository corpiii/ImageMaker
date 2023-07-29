//
//  PhotoCollectionViewCell.swift
//  ImageMaker
//
//  Created by 이정민 on 2023/07/30.
//

import UIKit
import SnapKit

class PhotoCollectionViewCell: UICollectionViewCell {
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        // 셀에 이미지뷰 추가
        addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(self.snp.edges)
        }
    }
}
