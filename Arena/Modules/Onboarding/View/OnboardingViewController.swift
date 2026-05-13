//
//  OnboardingViewController.swift
//  Arena
//
//  Created by Abdelrahman on 05/05/2026.
//

import UIKit

class OnboardingViewController: UIViewController,  UIPageViewControllerDataSource, UIPageViewControllerDelegate , OnboardingViewProtocol {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextButton: UIButton!

    private var pageViewController: UIPageViewController!
    private var presenter: OnboardingPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = AppContainer.shared.makeOnboardingPresenter(view: self)
        setupUI()
        setupPageViewController()
        presenter.viewDidLoad()
    }

    private func setupUI() {
        nextButton.backgroundColor = UIColor(red: 0/255, green: 88/255, blue: 188/255, alpha: 1.0)
        nextButton.layer.cornerRadius = 12
        pageControl.numberOfPages = presenter.numberOfPages
    }

    private func setupPageViewController() {
        let pageVC = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        pageVC.dataSource = self
        pageVC.delegate = self
        addChild(pageVC)
        pageVC.view.frame = containerView.bounds
        containerView.addSubview(pageVC.view)
        pageVC.didMove(toParent: self)

        self.pageViewController = pageVC
    }

    @IBAction func nextButtonTapped(_ sender: UIButton) {
        presenter.didTapNext()
    }
    
    func showPage(at index: Int, data: OnboardingPage) {
        let direction: UIPageViewController.NavigationDirection = index >= pageControl.currentPage ? .forward : .reverse
        let vc = createOnboardingContent(with: data, index: index)
        pageViewController.setViewControllers([vc], direction: direction, animated: true)
        pageControl.currentPage = index
        
    }
    
    func updateButtonName(_ isLastPage: Bool) {
        let title = isLastPage ? "Get Started" :  "Next"
        var config = nextButton.configuration
        config?.attributedTitle = AttributedString(title, attributes: AttributeContainer([
            .font: nextButton.configuration?.attributedTitle?.runs.first?.font ?? UIFont.systemFont(ofSize: 17)
        ]))
        nextButton.configuration = config
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentVC = viewController as? OnboardingContentViewController else { return nil }
        let previousIndex = currentVC.pageIndex - 1
        guard let data = presenter.getPageData(at: previousIndex) else { return nil }
        return createOnboardingContent(with: data, index: previousIndex)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentVC = viewController as? OnboardingContentViewController else { return nil }
        let nextIndex = currentVC.pageIndex + 1
        guard let data = presenter.getPageData(at: nextIndex) else { return nil }
        return createOnboardingContent(with: data, index: nextIndex)
    }

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard completed,
              let currentVC = pageViewController.viewControllers?.first as? OnboardingContentViewController else { return }
        presenter.didFinishSwiping(to: currentVC.pageIndex)
    }
    
    func createOnboardingContent(with data: OnboardingPage, index: Int) -> OnboardingContentViewController {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: Routes.onboardingContentVC) as! OnboardingContentViewController
        vc.pageData = data
        vc.pageIndex = index
        return vc;
    }

    func updatePageControl(index: Int) {
        pageControl.currentPage = index
    }

    func navigateToHome() {
        AppRouter.setRootViewController(AppRouter.makeMainApp())
    }
}
