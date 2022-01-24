//
//  BaseViewController.swift
//  PruebaCoppel
//
//  Created by Gustavo on 22/01/22.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    
    func createAlert(title: String, description: String){
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(alertAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func createAlertSheet(firstAction: UIAlertAction, secondAction: UIAlertAction){
        let alert = UIAlertController(title: "", message: "What do you want to do", preferredStyle: .actionSheet)
        let alertActionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let alertActionFirst = firstAction
        let alertActionSecond = secondAction
        alert.addAction(alertActionCancel)
        alert.addAction(alertActionFirst)
        alert.addAction(alertActionSecond)
        self.present(alert, animated: true, completion: nil)
    }
    
    func presentViewController(view: BaseViewController, presentation: UIModalPresentationStyle){
        let viewController = view
        let navigationController = UINavigationController()
        navigationController.viewControllers = [viewController]
        navigationController.modalPresentationStyle = presentation
        present(navigationController, animated: true, completion: nil)
    }
    
    func dismissView(){
        dismiss(animated: true, completion: nil)
    }
    
    func configureNavBar(background: UIColor, tintColor: UIColor, title: String){
        let apparence = UINavigationBarAppearance()
        apparence.configureWithTransparentBackground()
        apparence.backgroundColor = background
        let titleAtribute = ([NSAttributedString.Key.foregroundColor : tintColor])
        apparence.titleTextAttributes = titleAtribute
        navigationController?.navigationBar.tintColor = tintColor
        navigationItem.title = title
        navigationController?.navigationBar.standardAppearance = apparence
        navigationController?.navigationBar.scrollEdgeAppearance = apparence
    }
    
    func pushViewController(vc: BaseViewController){
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func setRightButton(action: Selector){
        let rightButton: UIButton = UIButton(type: .custom)
        rightButton.setImage(UIImage(systemName: "list.dash"), for: .normal)
        rightButton.tintColor = .white
        rightButton.addTarget(self, action: action, for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: rightButton)
        self.navigationItem.rightBarButtonItem = barButton
    }
}
