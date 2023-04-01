import UIKit

final class SettingsViewController: UIViewController{
    //MARK: - Properties
    let sections: [Section] = [.init(section: .settings, rows: [.userMode, .carType, .changeCity, .selectLanguage])]
    
    //MARK: - UI
    private lazy var settingTableView = UITableView()
    
    private lazy var feedbackButton: UIButton = {
        let feedbackButton = UIButton()
        feedbackButton.layer.cornerRadius = 16
        feedbackButton.setAttributedTitle(Typography.buttonMedium(text: RSConstants.feedBack, color: .textWhite).styled, for: .normal)
        feedbackButton.addTarget(self, action: #selector(toFeedback), for: .touchUpInside)
        
        return feedbackButton
    }()
    
    //MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    //MARK: - Methods
    @objc func toFeedback(){
        navigationController?.pushViewController(FeedbackViewController(), animated: true)
    }
    
    private func setup(){
        setupViews()
        setupColors()
        makeConstraints()
        configureTableView()
    }
    
    private func setupViews(){
        [settingTableView, feedbackButton].forEach {
            view.addSubview($0)
        }
    }
    
    private func makeConstraints(){
        settingTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        feedbackButton.snp.makeConstraints { make in
            make.height.equalTo(53)
            make.width.equalTo(UIScreen.main.bounds.width/1.108)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(UIScreen.main.bounds.height/1.28)
        }
    }
    
    private func setupColors() {
        feedbackButton.backgroundColor = .mainBlue
    }
    
    private func configureTableView() {
        settingTableView.delegate = self
        settingTableView.dataSource = self
        settingTableView.register(cellClass: SettingsCell.self)
    }
}



