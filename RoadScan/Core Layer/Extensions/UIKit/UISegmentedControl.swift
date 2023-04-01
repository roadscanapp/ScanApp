import Foundation
import UIKit

extension UISegmentedControl{
    func removeBorder(){
        let background = UIImage.getSegRect(color: UIColor.white.cgColor,
                                            andSize: self.bounds.size)
        self.setBackgroundImage (background,
                                 for: .normal,
                                 barMetrics: .default)
        self.setBackgroundImage (background,
                                 for: .selected,
                                 barMetrics: .default)
        self.setBackgroundImage (background,
                                 for: .highlighted,
                                 barMetrics: .default)
        
        let deviderLine = UIImage.getSegRect(
                                 color: UIColor.white.cgColor,
                                 andSize: CGSize(width: 1.0, height: 5))
        
        self.setDividerImage(deviderLine,
                            forLeftSegmentState: .selected,
                            rightSegmentState: .normal,
                            barMetrics: .default)
    }
}
