//
//  MainViewController.swift
//  ColorizeApp
//
//  Created by Veronika Iskandarova on 7.06.2024.
//

import UIKit

final class MainViewController: UIViewController {
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }
        settingsVC.delegate = self
        settingsVC.currentColor = view.backgroundColor
    }
}

extension MainViewController: SettingsViewControllerDelegate {
    func settingsViewController(_ controller: SettingsViewController, didSelectedColor color: UIColor) {
        view.backgroundColor = color
    }
}
