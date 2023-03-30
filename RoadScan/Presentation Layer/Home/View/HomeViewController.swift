import UIKit
import GoogleMaps
import SnapKit

final class HomeViewController: UIViewController {

    var centerMarker: GMSMarker?
    let array = ["redCircle", "brownCircle", "greenCircle"]
    private let locationService = LocationService()
    private let coreMotionService = CoreMotionService()
    
    var mapView = GMSMapView()
    
    /// need delete
    let items = ["Точки",
                 "Цветовые схемы"]
    
    private lazy var plusZoom: UIButton = {
        let plusZoom = UIButton()
        plusZoom.setBackgroundImage(UIImage(named: "Plus"), for: .normal)
        
        return plusZoom
    }()
    
    private lazy var minusZoom: UIButton = {
        let minusZoom = UIButton()
        minusZoom.setBackgroundImage(UIImage(named: "Minus"), for: .normal)
        
        return minusZoom
    }()
    
    private lazy var myLocation: UIButton = {
        let myLocation = UIButton()
        myLocation.setBackgroundImage(UIImage(named: "myLocation"), for: .normal)
        myLocation.addTarget(self, action: #selector(showMyLocation), for: .touchUpInside)
        
        return myLocation
    }()
    
    private lazy var viewToSC: UIView = {
        let viewToSC = UIView()
        viewToSC.addSubview(segControl)
        
        return viewToSC
    }()
    
    private lazy var segControl: UISegmentedControl = {
        var segControl = UISegmentedControl()
        segControl = UISegmentedControl(items: items)
        segControl.removeBorder()
        segControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.mainBlue], for: .selected)
        segControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(red: 0.459,
                                                                                           green: 0.459,
                                                                                           blue: 0.459,
                                                                                           alpha: 1)],
                                                                                           for: .normal)
        segControl.selectedSegmentIndex = 0
        return segControl
    }()
    
    override func loadView() {
        super.loadView()
        locationService.delegate = self
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
       
        let camera = GMSCameraPosition.camera(withLatitude: 0.0,
                                              longitude:   0.0,
                                              zoom:         0)
        mapView = GMSMapView.map(withFrame: view.frame,
                                     camera: camera)
        mapView.camera = camera
        
        self.view.addSubview(mapView)
        setup()
    }
    
    private func setup() {
        setUpGoogleMaps()
        initialize()
        makeConstraints()
        coreMotionService.startMotion()
        coreMotionService.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureViewLayer()
    }
    
    // нужно написать extetion
    private func configureViewLayer() {
        viewToSC.layer.masksToBounds = false
        viewToSC.layer.cornerRadius = 16
        viewToSC.layer.shadowRadius = 4
        viewToSC.layer.shadowOpacity = 1
        viewToSC.layer.shadowColor = UIColor(red: 0,
                                             green: 0,
                                             blue: 0,
                                             alpha:0.15).cgColor
    }
    
    // нужно удалить метод или обьекти если не юзается
    private func setUpGoogleMaps(){
        addMarker(to: mapView, at: 43.238949, and: 76.945451, with: "Republic Square")
        addMarker(to: mapView, at: 43.222278, and: 76.947694, with: "Koktobe Hill")
        addMarker(to: mapView, at: 43.256942, and: 76.943367, with: "Zenkov Cathedral")
        addMarker(to: mapView, at: 43.175478, and: 77.049082, with: "Medeu Skating Rink")
        var coordinates = [CLLocationCoordinate2D]()

        coordinates.append(CLLocationCoordinate2D(latitude: 43.238949, longitude: 76.945451))
        coordinates.append(CLLocationCoordinate2D(latitude: 43.222278, longitude: 76.947694))
        coordinates.append(CLLocationCoordinate2D(latitude: 43.256942, longitude: 76.943367))
        coordinates.append(CLLocationCoordinate2D(latitude: 43.175478, longitude: 77.049082))

        let path = GMSMutablePath()
        for coordinate in coordinates {
            path.add(coordinate)
        }

        let polyline = createPolyline(from: path, with: .blue, and: 5.0)
        polyline.map = mapView
    }
    private func addMarker(to mapView: GMSMapView, at latitude: CLLocationDegrees, and longitude: CLLocationDegrees, with title: String) {
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        marker.title = title
        let imageView = UIImageView(image: UIImage(named: array[Int.random(in: 0...2)]))
                imageView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        marker.iconView = imageView
        marker.map = mapView
    }
    private func createPolyline(from path: GMSMutablePath, with strokeColor: UIColor, and strokeWidth: CGFloat) -> GMSPolyline {
        let polyline = GMSPolyline(path: path)
        polyline.strokeColor = strokeColor
        polyline.strokeWidth = strokeWidth
        return polyline
    }
    // constraint не должны быть много чем 54
    private func makeConstraints() {
        viewToSC.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(50)
            make.centerX.equalToSuperview()
            make.width.equalTo(358)
            make.height.equalTo(46)
        }
        
        plusZoom.snp.makeConstraints { make in
            make.width.height.equalTo(46)
            make.top.equalToSuperview().inset(343)
            make.right.equalToSuperview().inset(12)
        }
        
        minusZoom.snp.makeConstraints { make in
            make.width.height.equalTo(46)
            make.top.equalTo(plusZoom.snp.bottom).offset(10)
            make.right.equalToSuperview().inset(12)
        }
        
        myLocation.snp.makeConstraints { make in
            make.width.height.equalTo(46)
            make.top.equalTo(minusZoom.snp.bottom).offset(10)
            make.right.equalToSuperview().inset(12)
        }
        
        segControl.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // создать extetion для view.addArangedSubviews []
    private func initialize() {
        view.addSubview(viewToSC)
        view.addSubview(plusZoom)
        view.addSubview(minusZoom)
        view.addSubview(myLocation)
    }
    
    @objc func showMyLocation() {
        print("my location")
    }
}

extension HomeViewController: CoreMotionServiceDelegate {
    func getCoordinateMotionDevice(with data: CoreMotionViewModel) {
        print("x ---------->", data.xPosition)
        print("y ---------->", data.yPosition)
        print("z----------->", data.zPosition)
    }
}

// MARK: - LocationService Delegate
extension HomeViewController: LocationServiceProtocol {
    func getCurrentLocation(with location: CurrentLocationModel) {
        let camera = GMSCameraPosition.camera(withLatitude: location.lat,
                                              longitude:   location.lon,
                                              zoom:         15.0)
        
        mapView.animate(to: camera)
    }
}
