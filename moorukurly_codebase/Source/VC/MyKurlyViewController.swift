//
//  MyKurlyViewController.swift
//  moorukurly_codebase
//
//  Created by 윤예지 on 2021/05/28.
//

import UIKit

class MyKurlyViewController: UIViewController {

    // MARK: - UI Properties
    var headerView = HeaderView()
    var mainTableView = UITableView()
    
    // MARK: - Properties
    var firstSectionData = ["비회원 주문 조회", "알림 설정"]
    var secondSectionData = ["컬리소개", "배송 안내", "공지사항", "자주하는 질문", "고객센터", "이용안내"]
    
    var noLoginView = NoLoginView()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUI()
        setTableView()
    }
    

    func setUI() {
        view.addSubviews(headerView, mainTableView, noLoginView)
        
        headerView.snp.makeConstraints {
            headerView.titleLabel.text = "마이컬리"
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(88)
        }
        
        mainTableView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.leading.bottom.trailing.equalToSuperview()
        }
        
        noLoginView.loginButton.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
    }
    
    func setTableView() {
        mainTableView.delegate = self
        mainTableView.dataSource = self
        
        mainTableView.separatorStyle = .none
        mainTableView.backgroundColor = .gray
        
        mainTableView.register(MyPageTableViewCell.self, forCellReuseIdentifier: "MyPageTableViewCell")
    }
    
    @objc
    func loginButtonClicked() {
        let loginViewController = LoginViewController()
        loginViewController.modalPresentationStyle = .overFullScreen
        self.present(loginViewController, animated: true, completion: nil)
    }

}

extension MyKurlyViewController: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 180
        case 1...2:
            return 10
        default:
            return 0
        }
        
    }
       
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            return noLoginView
        case 1...2:
            let view = UIView()
            view.backgroundColor = .gray
            return view
        default:
            return UIView()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
}

extension MyKurlyViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 1:
            return firstSectionData.count
        case 2:
            return secondSectionData.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageTableViewCell", for: indexPath) as? MyPageTableViewCell else { return UITableViewCell() }
            cell.setUI()
            cell.setData(title: firstSectionData[indexPath.row])
            cell.selectionStyle = .none
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageTableViewCell", for: indexPath) as? MyPageTableViewCell else { return UITableViewCell() }
            cell.setUI()
            cell.setData(title: secondSectionData[indexPath.row])
            cell.selectionStyle = .none
            return cell
        default:
            return UITableViewCell()
        }
    }
}
