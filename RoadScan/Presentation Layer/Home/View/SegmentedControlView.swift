import UIKit
import SnapKit

final class SegmentedControlView: UIView {
    //MARK: - Properties
    let items = [RSConstants.segmentItemsPoints, RSConstants.segmentItemsColorSchemes]
    
    //MARK: - UI
    private lazy var segControl: UISegmentedControl = {
        var segControl = UISegmentedControl()
        segControl = UISegmentedControl(items: items)
        segControl.removeBorder()
        segControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.mainBlue], for: .selected)
        segControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.textGray], for: .normal)
        segControl.selectedSegmentIndex = 0
        return segControl
    }()
    
    //MARK: - Init
    public init() {
        super.init(frame: .zero)

        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    private func setup() {
        setupViews()
        makeConstraints()
        setupShadow(masksToBounds: false, cornerRadius: 16, shadowRadius: 4, shadowOpacity: 1, shadowColor: UIColor.SCShadowColor.cgColor)
    }
    
    private func setupViews() {
        [segControl].forEach {
            addSubview($0)
        }
    }
    
    private func makeConstraints() {
        segControl.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
}
