extension SettingsViewController {
    struct Section {
        enum Section {
            case settings
        }
        
        enum Row {
            case userMode
            case carType
            case changeCity
            case selectLanguage
        }
        
        let section: Section
        var rows: [Row]
    }
}
