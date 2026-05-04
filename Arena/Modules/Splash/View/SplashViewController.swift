//
//  SplashViewController.swift
//  Arena
//
//  Created by Abdelrahman on 04/05/2026.
//

import UIKit

import UIKit

class SplashViewController: UIViewController {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var arenaLabel: UILabel!
    @IBOutlet weak var taglineLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!

    override func viewDidLoad() {
        super.viewDidLoad()
        progressBar.progress = 0
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        runSplashSequence()
    }

    private func runSplashSequence() {
        logoImageView.alpha = 0
        arenaLabel.alpha = 0
        taglineLabel.alpha = 0
        progressBar.alpha = 0

        logoImageView.transform = CGAffineTransform(scaleX: 0.4, y: 0.4)
        UIView.animate(
            withDuration: 0.7,
            delay: 0.2,
            usingSpringWithDamping: 0.55,
            initialSpringVelocity: 0.8,
            options: .curveEaseOut
        ) {
            self.logoImageView.alpha = 1
            self.logoImageView.transform = .identity
        }

        UIView.animate(withDuration: 0.5, delay: 0.7, options: .curveEaseOut) {
            self.arenaLabel.alpha = 1
        }

        UIView.animate(withDuration: 0.5, delay: 1.0, options: .curveEaseOut) {
            self.taglineLabel.alpha = 1
        }

        UIView.animate(withDuration: 0.3, delay: 1.3, options: .curveEaseOut) {
            self.progressBar.alpha = 1
        } completion: { _ in
            UIView.animate(withDuration: 1.8, delay: 0.1, options: .curveEaseInOut) {
                self.progressBar.setProgress(1.0, animated: true)
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
            self.navigateNext()
        }
    }

    private func navigateNext() {
        
    }
}
