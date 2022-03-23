//
//  LoginViewController.swift
//  Remote examination
//
//  Created by Anna Abdeeva on 20.03.2022.
//

import Moya
import UIKit

final class LoginViewController: UIViewController {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var entranceButton: UIButton!
    @IBOutlet weak var noAccountButton: UIButton!
    
    private var loginCredentials = ""
    private var token = ""
    private var shouldPerformSegue = false
    
    @IBAction func didTapEntranceButton(_ sender: Any) {
        guard let encodedLoginCredentials = "\(emailField.text ?? ""):\(passwordField.text ?? "")".base64Encoded else {
            showWrongCredsAlert()
            return
        }
        
        loginCredentials = encodedLoginCredentials
        
        performLoginRequest { [weak self] result in
            switch result {
            case let .success(token):
                self?.token = token
                NotificationCenter.default.post(name: Notification.Name("didReceiveToken"), object: token)
                
            case .failure:
                self?.showWrongCredsAlert()
            }
        }
    }
    @IBAction func didTapNoAccountButton(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailField.placeholder = "Логин"
        passwordField.placeholder = "Пароль"
        self.passwordField.isSecureTextEntry = !self.passwordField.isSecureTextEntry
        
    }
}

// MARK: -

private extension LoginViewController {
    func performLoginRequest(completion: @escaping (Result<String, Error>) -> Void) {
        let target = ExamsAPITarget(
            endpoint: .production,
            route: .login(loginCredentials)
        )
        
        let provider = MoyaProvider<ExamsAPITarget>()
        
        provider.request(target) { result in
            switch result {
            case let .success(response):
                guard let loginResponse = try? response.map(LoginResponse.self) else {
                    completion(.failure(StudentAPIError.a))
                    return
                }
                completion(.success(loginResponse.token))
                
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    func showWrongCredsAlert() {
        showOKAlert(
            title: "Ошибка",
            message: "Указаны неправильный логин или пароль, попробуйте снова"
        )
    }

}
