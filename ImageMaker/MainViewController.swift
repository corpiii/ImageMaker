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
    }
}
