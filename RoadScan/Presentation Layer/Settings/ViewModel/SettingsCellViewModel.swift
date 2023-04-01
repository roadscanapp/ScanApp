import Foundation

protocol SettingsCellViewModelProtocol {
    var title: NSAttributedString? { get }
}

struct SettingsCellViewModel: SettingsCellViewModelProtocol {
    //MARK: - Properties
    typealias Row = SettingsViewController.Section.Row
    
    let row: Row
    
    //MARK: - SettingsCellViewModelProtocol
    var title: NSAttributedString? {
        var text = ""
        switch row {
        case .userMode:
            text = RSConstants.userMode
        case .carType:
            text = RSConstants.carType
        case .changeCity:
            text = RSConstants.changeCity
        case .selectLanguage:
            text = RSConstants.selectLanguage
        }
        
        return Typography.bodyFirstRegular(text: text).styled
    }
}
