import UIKit

extension UIView {
    public func setupShadow(
        masksToBounds: Bool,
        cornerRadius: CGFloat,
        shadowRadius: CGFloat,
        shadowOpacity: Float,
        shadowColor: CGColor
    ) {
        layer.masksToBounds = masksToBounds
        layer.cornerRadius = cornerRadius
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = shadowOpacity
        layer.shadowColor = shadowColor
    }
}
