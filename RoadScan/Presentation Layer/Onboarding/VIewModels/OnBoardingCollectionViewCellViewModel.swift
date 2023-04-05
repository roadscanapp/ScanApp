import Foundation

protocol OnBoardingCollectionViewCellViewModelProtocol {
    var text: NSAttributedString? { get }
    var imageText: String { get }
    var buttonText: NSAttributedString? { get }
}

struct OnBoardingCollectionViewCellViewModel: OnBoardingCollectionViewCellViewModelProtocol {
    
    typealias Row = OnBoardingViewController.Section.Row
    
    //MARK: - Proprties
    let row: Row
    
    //MARK: - OnBoardingCollectionViewCellViewModelProtocol
    var text: NSAttributedString? {
        var text = ""
        switch row {
        case .first:
            text = RSConstants.firstOnboardingText
            return Typography.headlineFirst(text: text, color: .white, textAlignment: .center).styled
        case .second:
            text = RSConstants.secondOnboardingText
            return Typography.headlineSecond(text: text, color: .white, textAlignment: .center).styled
        case .third:
            text = RSConstants.thirdOnboardingText
            return Typography.headlineSecond(text: text, color: .white, textAlignment: .center).styled
        }
    }
    
    var imageText: String {
        switch row {
        case .first:
            return RSAssets.firstOnboardingImage
        case .second:
            return RSAssets.secondOnboardingImage
        case .third:
            return RSAssets.thirdOnboardingImage
        }
    }
    
    var buttonText: NSAttributedString? {
        var text = ""
        switch row {
        case .first, .second:
            text = RSConstants.nextButtonText
        case .third:
            text = RSConstants.allowButtonText
        }
        
        return Typography.buttonMedium(text: text, color: .white).styled
    }
}
