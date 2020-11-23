//
//  DetailViewController.swift
//  Lessons4_SplitViewController
//
//  Created by user183355 on 07.11.2020.
//

import UIKit

final class DetailViewController: UIViewController {
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    @IBOutlet private weak var firstImageView: UIImageView!
    
    @IBOutlet private weak var secondImageView: UIImageView!
    
    @IBOutlet private weak var firstImageShadowView: UIView!
    
    @IBOutlet private weak var secondImageShadowView: UIView!
    
    @IBOutlet private weak var scrollView: UIScrollView!
    
    private let customNavigationTitle = UILabel(frame: CGRect(x: 150, y: 0,
                                                      width: 200,
                                                      height: 44))
    
    private var dataModel: DataModel? {
        didSet {
            self.set()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageViewsAppearance()
        self.navigationTitleAppearance()
    }
    
    func set() {
        self.loadViewIfNeeded()
        
        self.customNavigationTitle.text = dataModel?.title
        
        self.descriptionLabel.text = dataModel?.description
        
        self.firstImageView.image = dataModel?.image.first
        self.secondImageView.image = dataModel?.image.last
        
        self.scrollView.setContentOffset(.zero, animated: false)
    }
}

extension DetailViewController: CellSelectedDelegate {
    func cellSelected(data: DataModel) {
        self.dataModel = data
    }
}

extension DetailViewController {
    func imageViewsAppearance() {
        self.firstImageView.clipsToBounds = true
        self.firstImageView.layer.cornerRadius = 20
        
        self.secondImageView.clipsToBounds = true
        self.secondImageView.layer.cornerRadius = 20
        
        self.firstImageShadowView.backgroundColor = .clear
        self.firstImageShadowView.clipsToBounds = false
        self.firstImageShadowView.layer.shadowColor = UIColor.black.cgColor
        self.firstImageShadowView.layer.shadowOpacity = 1
        self.firstImageShadowView.layer.shadowRadius = 10
        self.firstImageShadowView.layer.shadowOffset = CGSize.zero
         
        self.secondImageShadowView.backgroundColor = .clear
        self.secondImageShadowView.clipsToBounds = false
        self.secondImageShadowView.layer.shadowColor = UIColor.black.cgColor
        self.secondImageShadowView.layer.shadowOpacity = 1
        self.secondImageShadowView.layer.shadowRadius = 10
        self.secondImageShadowView.layer.shadowOffset = CGSize.zero
        
        self.firstImageShadowView.addSubview(self.firstImageView)
        self.secondImageShadowView.addSubview(self.secondImageView)
    }
    
    func navigationTitleAppearance() {
        self.customNavigationTitle.numberOfLines = 2
        self.customNavigationTitle.textAlignment = .center
        self.customNavigationTitle.font = .boldSystemFont(ofSize: 17)
        self.customNavigationTitle.text = self.title
        self.navigationItem.titleView = customNavigationTitle
    }
}
