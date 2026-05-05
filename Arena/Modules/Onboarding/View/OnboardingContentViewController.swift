//
//  OnboardingContentViewController.swift
//  Arena
//
//  Created by Abdelrahman on 05/05/2026.
//

import UIKit


class OnboardingContentViewController: UIViewController {

    @IBOutlet weak var onboardingImage: UIImageView!
    @IBOutlet weak var onboardingTitle: UILabel!
    @IBOutlet weak var onboardingSubtitle: UILabel!

    var pageData: OnboardingPage?
    var pageIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let data = pageData else { return }
        onboardingImage.image = UIImage(named: data.imageName)
        onboardingImage.contentMode = .scaleAspectFill
        onboardingImage.clipsToBounds = true
        onboardingTitle.text = data.title
        onboardingSubtitle.text = data.description
    }
}
