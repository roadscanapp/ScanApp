// MARK: - CoreMotionService Delegate
extension HomeViewController: CoreMotionServiceDelegate {
    func getCoordinateMotionDevice(with data: CoreMotionViewModel) {
        print("x ---------->", data.xPosition)
        print("y ---------->", data.yPosition)
        print("z----------->", data.zPosition)
    }
}
