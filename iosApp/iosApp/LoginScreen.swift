import UIKit
import shared

class LoginScreen: UIViewController {

    // UI Elements
    var usernameTextField: UITextField!
    var passwordTextField: UITextField!
    var loginButton: UIButton!
    var loader: UIActivityIndicatorView!

    // Shared Kotlin Logic
    let loginPage = LoginPage(repository: LoginRepository())

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set background color
        self.view.backgroundColor = .white

        // Initialize UI elements
        setupUI()
    }

    func setupUI() {
        // Username TextField
        usernameTextField = UITextField()
        usernameTextField.placeholder = "Username"
        usernameTextField.borderStyle = .roundedRect
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(usernameTextField)

        // Password TextField
        passwordTextField = UITextField()
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(passwordTextField)

        // Loader (Activity Indicator)
        loader = UIActivityIndicatorView(style: .large)
        loader.color = .gray
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.isHidden = true
        self.view.addSubview(loader)

       // Login Button
               loginButton = UIButton(type: .system)
               loginButton.setTitle("Login", for: .normal)
               loginButton.translatesAutoresizingMaskIntoConstraints = false
               loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
               self.view.addSubview(loginButton)

               // Set Constraints
               NSLayoutConstraint.activate([
                   usernameTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                   usernameTextField.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
                   usernameTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8),
                   usernameTextField.heightAnchor.constraint(equalToConstant: 50),

                   passwordTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                   passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 20),
                   passwordTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8),
                   passwordTextField.heightAnchor.constraint(equalToConstant: 50),

                   loader.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                   loader.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),

                   loginButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                   loginButton.topAnchor.constraint(equalTo: loader.bottomAnchor, constant: 20),
                   loginButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8),
                   loginButton.heightAnchor.constraint(equalToConstant: 50)
               ])
           }

           @objc func loginButtonTapped() {
               guard let username = usernameTextField.text, !username.isEmpty,
                     let password = passwordTextField.text, !password.isEmpty else {
                   showAlert(message: "Please enter both username and password")
                   return
               }

               loader.isHidden = false
               loader.startAnimating()

               Task {
                   await loginPage.login(username: username, password: password) { isSuccess in
                       self.loader.stopAnimating()
                       self.loader.isHidden = true

                       let message = isSuccess ? "Login successful!" : "Invalid credentials"
                       self.showAlert(message: message)
                   }
               }
           }

           private func showAlert(message: String) {
               let alert = UIAlertController(title: "Login", message: message, preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "OK", style: .default))
               self.present(alert, animated: true)
           }
       }