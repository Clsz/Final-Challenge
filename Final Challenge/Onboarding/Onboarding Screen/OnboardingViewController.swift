//
//  OnboardingViewController.swift
//  Final Challenge
//
//  Created by Steven Gunawan on 26/12/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController, UIScrollViewDelegate{
    
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet{
            scrollView.delegate = self
        }
    }
    @IBOutlet weak var pageControl: UIPageControl!
    var slides : [Slide] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slides = createSlides()
        setupSlideScrollView(slides: slides)
        
        pageControl.numberOfPages = slides.count
        pageControl.currentPage = 0
        view.bringSubviewToFront(pageControl)
        self.navigationController?.navigationBar.isHidden = true
        
        self.scrollView.contentInsetAdjustmentBehavior = .never
    }
    
    
    
    
}
extension OnboardingViewController:OnBoardingInputData{
    func didTap() {
        let vc = ChooseRoleViewController()
        CKUserData.shared.saveOnboardingStatus(status: "isOnBoard")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
extension OnboardingViewController{
    func createSlides() -> [Slide] {
        
        let slide1:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide1.imageView.image = UIImage(named: "onboarding_1")
        slide1.mainTitle.text = "GET MORE MONEY"
        slide1.descLabel.text = "You can easily earn more income here! Every available job is listed here by tuitions in Jakarta and Tangerang."
        slide1.pushButton.isHidden = true
        
        let slide2:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide2.imageView.image = UIImage(named: "onboarding_2")
        slide2.mainTitle.text = "UP TO DATE"
        slide2.descLabel.text = "All the newest jobs that match your filters criteria will directly be notified to you!"
        slide2.pushButton.isHidden = true
        
        let slide3:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide3.imageView.image = UIImage(named: "onboarding_3")
        slide3.mainTitle.text = "KEEP ON TRACK"
        slide3.descLabel.text = "You will get clear information about your applied jobs progress!"
        slide3.pushButton.isHidden = false
        slide3.pushButton.loginRound()
        slide3.listener = self
        
        return [slide1, slide2, slide3]
        
    }
    
    func setupSlideScrollView(slides : [Slide]) {
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
        scrollView.isPagingEnabled = true
        
        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            scrollView.addSubview(slides[i])
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControl.currentPage = Int(pageIndex)

        let maximumHorizontalOffset: CGFloat = scrollView.contentSize.width - scrollView.frame.width
        let currentHorizontalOffset: CGFloat = scrollView.contentOffset.x

        // vertical
        let maximumVerticalOffset: CGFloat = scrollView.contentSize.height - scrollView.frame.height
        let currentVerticalOffset: CGFloat = scrollView.contentOffset.y

        let percentageHorizontalOffset: CGFloat = currentHorizontalOffset / maximumHorizontalOffset
        let percentageVerticalOffset: CGFloat = currentVerticalOffset / maximumVerticalOffset

        let percentOffset: CGPoint = CGPoint(x: percentageHorizontalOffset, y: percentageVerticalOffset)
        
        if(percentOffset.x > 0 && percentOffset.x <= 0.33) {
            slides[0].imageView.transform = CGAffineTransform(scaleX: (0.33-percentOffset.x)/0.33, y: (0.33-percentOffset.x)/0.33)
            slides[1].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.33, y: percentOffset.x/0.33)

        } else if(percentOffset.x > 0.33 && percentOffset.x <= 0.67) {
            slides[1].imageView.transform = CGAffineTransform(scaleX: (0.78-percentOffset.x)/0.33, y: (0.78-percentOffset.x)/0.33)
            slides[2].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.67, y: percentOffset.x/0.67)

        } else if(percentOffset.x > 0.67 && percentOffset.x <= 1.0) {
            slides[2].imageView.transform = CGAffineTransform(scaleX: (1.3-percentOffset.x)/0.33, y: (1.3-percentOffset.x)/0.33)

        }
    }
}




