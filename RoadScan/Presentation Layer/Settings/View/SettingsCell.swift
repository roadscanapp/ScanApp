import Foundation
import UIKit
import SnapKit

final class SettingsCell: UITableViewCell {
    
    //MARK: - UI
    private lazy var titleLabel = UILabel()
    
    private lazy var vectorButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: RSAssets.settingsCellVector), for: .normal)
        
        return button
    }()

    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    private func setup(){
        setupViews()
        makeConstrainst()
    }
    
    private func setupViews() {
        [titleLabel,vectorButton].forEach {
            contentView.addSubview($0)
        }
    }
    
    private func makeConstrainst() {
        titleLabel.snp.makeConstraints{ maker in
            maker.centerY.equalToSuperview()
            maker.left.equalToSuperview().inset(19)
        }

        vectorButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.width.equalTo(20)
            make.right.equalToSuperview().inset(19)
        }
    }
    
    public func configure(with viewModel: SettingsCellViewModelProtocol) {
        titleLabel.attributedText = viewModel.title
    }
}
