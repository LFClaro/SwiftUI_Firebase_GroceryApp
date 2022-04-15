//
//  AlertControlView.swift
//  SwiftUI with UIAlertController
//
//  Created by Nasir Ahmed Momin on 03/05/20.
//  Copyright © 2020 Nasir Ahmed Momin. All rights reserved.
//
//  Adapted by Luiz Claro on 2022-04-15.
//

import SwiftUI
import Firebase

struct AlertControlView: UIViewControllerRepresentable {
    
    @Binding var textStringEmail: String
    @Binding var textStringPassword: String
    @Binding var showAlert: Bool
    
    var title: String
    var message: String
    var placeholderEmail: String?
    var placeholderPassword: String?
    
    // Make sure that, this fuction returns UIViewController, instead of UIAlertController.
    // Because UIAlertController gets presented on UIViewController
    func makeUIViewController(context: UIViewControllerRepresentableContext<AlertControlView>) -> UIViewController {
        return UIViewController() // Container on which UIAlertContoller presents
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<AlertControlView>) {
        
        // Make sure that Alert instance exist after View's body get re-rendered
        guard context.coordinator.alert == nil else { return }
        
        if self.showAlert {
            
            // Create UIAlertController instance that is gonna present on UIViewController
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            context.coordinator.alert = alert
            
            // Adds UITextField & make sure that coordinator is delegate to UITextField.
            alert.addTextField { textFieldEmail in
                textFieldEmail.placeholder = placeholderEmail ?? "Enter your email"
                textFieldEmail.text = self.textStringEmail            // setting initial value
                textFieldEmail.delegate = context.coordinator    // using coordinator as delegate
            }
            
            // Addind a second UITextField & make sure that coordinator is delegate to UITextField.
            alert.addTextField { textFieldPassword in
                textFieldPassword.placeholder = placeholderPassword ?? "Enter your password"
                textFieldPassword.text = self.textStringPassword            // setting initial value
                textFieldPassword.delegate = context.coordinator    // using coordinator as delegate
            }
            
            // As usual adding actions
            alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: "") , style: .destructive) { _ in
                
                // On dismiss, SiwftUI view's two-way binding variable must be update (setting false) means, remove Alert's View from UI
                alert.dismiss(animated: true) {
                    self.showAlert = false
                }
            })
            
            alert.addAction(UIAlertAction(title: NSLocalizedString("Submit", comment: ""), style: .default) { _ in
                // On submit action, get texts from TextField & set it on SwiftUI View's two-way binding varaible `textString` so that View receives enter response.
                if let textField = alert.textFields?[0], let text = textField.text {
                    self.textStringEmail = text
                }

                if let textField = alert.textFields?[1], let text = textField.text {
                    self.textStringPassword = text
                }
                
                Task {
                    print("\(textStringEmail)\n \(textStringPassword)")
                    Auth.auth().createUser(withEmail: textStringEmail, password: textStringPassword) { user, error in
                        //MARK: - If there is no error, perform a signIn using the Auth library signIn function
                        if error == nil {
                            Auth.auth().signIn(withEmail: textStringEmail, password: textStringPassword)
                            print("USER ====> \(String(describing: user))")
                        } else {
                            print("FIREBASE ERROR HERE ====> \(String(describing: error))")
                        }
                    }
                }
                
                alert.dismiss(animated: true) {
                    self.showAlert = false
                }
            })
            
            // Most important, must be dispatched on Main thread,
            // Curious? then remove `DispatchQueue.main.async` & find out yourself, Dont be lazy
            DispatchQueue.main.async { // must be async !!
                uiViewController.present(alert, animated: true, completion: {
                    self.showAlert = false  // hide holder after alert dismiss
                    context.coordinator.alert = nil
                })
                
            }
        }
    }
    
    func makeCoordinator() -> AlertControlView.Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        
        // Holds reference of UIAlertController, so that when `body` of view gets re-rendered so that Alert should not disappear
        var alert: UIAlertController?
        
        // Holds back reference to SwiftUI's View
        var control: AlertControlView
        
        init(_ control: AlertControlView) {
            self.control = control
        }
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if let text = textField.text as NSString? {
                self.control.textStringEmail = text.replacingCharacters(in: range, with: string)
            } else {
                self.control.textStringEmail = ""
            }
            return true
        }
    }
}
