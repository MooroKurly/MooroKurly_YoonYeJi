//
//  ViewController.swift
//  moorukurly_codebase
//
//  Created by 윤예지 on 2021/06/17.
//

import UIKit

class LoginViewController: UIViewController {

    var titleLabel = UILabel().then {
        $0.text = "로그인"
    }
    
    var closeButton = UIButton().then {
        $0.setImage(UIImage(systemName: "xmark"), for: .normal)
        $0.tintColor = .black
    }
    
    var idTextField = TextFieldWithPadding().then {
        $0.placeholder = "아이디를 입력해주세요"
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray.cgColor
        $0.layer.cornerRadius = 5
        $0.font = UIFont.systemFont(ofSize: 12, weight: .bold)
    }
    
    var passwordTextField = TextFieldWithPadding().then {
        $0.placeholder = "비밀번호를 입력해주세요"
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray.cgColor
        $0.layer.cornerRadius = 5
        $0.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        $0.isSecureTextEntry = true
    }
    
    var signInButton = UIButton().then {
        $0.setTitle("로그인", for: .normal)
        $0.backgroundColor = .purple
        $0.layer.cornerRadius = 3
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
    }
    
    var signUpButton = UIButton().then {
        $0.setTitle("회원가입", for: .normal)
        $0.setTitleColor(.purple, for: .normal)
        $0.layer.borderWidth = 0.5
        $0.layer.borderColor = UIColor.purple.cgColor
        $0.layer.cornerRadius = 3
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setUI()
    }
    
    func setUI() {
        view.addSubviews(idTextField, passwordTextField, signInButton, signUpButton, titleLabel, closeButton)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(64)
            $0.centerX.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.top)
            $0.leading.equalTo(16)
            $0.width.height.equalTo(16)
        }
        
        idTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(idTextField.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        signInButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(40)
        }
        
        signUpButton.snp.makeConstraints {
            $0.top.equalTo(signInButton.snp.bottom).offset(40)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(40)
        }
        
        signInButton.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        closeButton.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
    }

    @objc
    func loginAction() {
        LoginService.shared.login(id: idTextField.text!, password: passwordTextField.text!) { result in
            switch result {
            case .success(let msg):
                print("성공")
            case .requestErr(let msg):
                print("실패")
            default:
                print("error")
            }
        }
    }
    
    @objc
    func closeAction() {
        self.dismiss(animated: false, completion: nil)
    }
}
