//
//  DetailViewController.swift
//  Lessons4_SplitViewController
//
//  Created by user183355 on 07.11.2020.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var firstImageView: UIImageView!
    
    @IBOutlet weak var secondImageView: UIImageView!
    
    @IBOutlet weak var firstImageShadowView: UIView!
    
    @IBOutlet weak var secondImageShadowView: UIView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    let customNavigationTitle = UILabel(frame: CGRect(x: 150, y: 0,
                                                      width: 200,
                                                      height: 44))
    
    var dataModel: DataModel? {
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
