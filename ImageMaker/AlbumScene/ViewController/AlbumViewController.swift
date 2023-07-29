//
//  AlbumViewController.swift
//  ImageMaker
//
//  Created by 이정민 on 2023/07/30.
//

import UIKit

class AlbumViewController: UIViewController {
    private let reuseIdentifier = "PhotoCell"
    private let itemsPerRow: CGFloat = 3
    private let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
    private let imageConfiguration: ImageConfiguration
    private let karloService: KarloService = .init()
    
    private var photos: [UIImage] = []

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        return collectionView
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configCollectionView()
        configIndicatorView()
        activityIndicator.startAnimating()
        
        karloService.perfromImageGeneration(imageConfiguration) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let base64Array):
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                }
                base64Array.forEach { string in
                    guard let data = Data(base64Encoded: string),
                          let image = UIImage(data: data) else {
                        return
                    }
                    
                    self.photos.append(image)
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    init(imageConfiguration: ImageConfiguration) {
        self.imageConfiguration = imageConfiguration
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension AlbumViewController {
    func configIndicatorView() {
        self.view.addSubview(activityIndicator)
        
        activityIndicator.color = Constant.textColor
        activityIndicator.snp.makeConstraints { make in
            make.center.equalTo(self.view.snp.center)
        }
    }
    
    func configCollectionView() {
        self.view.addSubview(collectionView)
        self.view.backgroundColor = Constant.backGroundColor
        self.collectionView.backgroundColor = Constant.backGroundColor
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide.snp.edges)
        }
    }
}

// MARK: - UICollectionViewDataSource
extension AlbumViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCollectionViewCell
        cell.imageView.image = photos[indexPath.item]
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension AlbumViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let image = photos[indexPath.item]
        let detailViewController = DetailViewController(image: image)
        
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
