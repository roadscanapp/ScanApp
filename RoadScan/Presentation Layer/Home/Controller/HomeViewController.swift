import UIKit
import GoogleMaps
import SnapKit

final class HomeViewController: UIViewController {
    //MARK: - Properties
    private let locationService = LocationService()
    private let coreMotionService = CoreMotionService()
    private let googleMapsService = GoogleMapsService()
    private let viewModel = HomeViewModel()
    
    //MARK: - UI
    private lazy var segmentedControlView = SegmentedControlView()
    
    private lazy var plusZoom: UIButton = {
        let plusZoom = UIButton()
        plusZoom.setBackgroundImage(UIImage(named: RSAssets.mapPlusZoom), for: .normal)
        plusZoom.addTarget(self, action: #selector(plusZoomDidTap), for: .touchUpInside)
        
        return plusZoom
    }()
    
    private lazy var minusZoom: UIButton = {
        let minusZoom = UIButton()
        minusZoom.setBackgroundImage(UIImage(named: RSAssets.mapMinusZoom), for: .normal)
        minusZoom.addTarget(self, action: #selector(minusZoomDidTap), for: .touchUpInside)
        
        return minusZoom
    }()
    
    private lazy var myLocation: UIButton = {
        let myLocation = UIButton()
        myLocation.setBackgroundImage(UIImage(named: RSAssets.mapMyLoaction), for: .normal)
        myLocation.addTarget(self, action: #selector(showMyLocation), for: .touchUpInside)
        
        return myLocation
    }()
    
    public var mapView = GMSMapView()
    
    //MARK: - Init
    override func loadView() {
        super.loadView()
        configureLocationService()
        binding()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    //MARK: - Methods
    @objc func showMyLocation() {
        let camera = googleMapsService.getMyCameraPosition(mapView: mapView)
        mapView.animate(to: camera)
    }
    
    @objc func plusZoomDidTap() {
        let zoomInValue = googleMapsService.getZoomInValue(mapView: mapView)
        mapView.animate(toZoom: zoomInValue)
    }
    
    @objc func minusZoomDidTap() {
        let zoomOutValue = googleMapsService.getZoomOutValue(mapView: mapView)
        mapView.animate(toZoom: zoomOutValue)
    }
    
    private func setup() {
        setUpGoogleMaps()
        setupViews()
        makeConstraints()
        configureCoreMotion()
    }
    
    private func setUpGoogleMaps(){
        mapView = googleMapsService.setupMapView(view: view)
        view.addSubview(mapView)
    }

    private func makeConstraints() {
        segmentedControlView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(50)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(UIScreen.main.bounds.width/1.09)
            $0.height.equalTo(46)
        }
        
        plusZoom.snp.makeConstraints {
            $0.width.height.equalTo(46)
            $0.top.equalToSuperview().inset(UIScreen.main.bounds.width/1.137)
            $0.right.equalToSuperview().inset(12)
        }
        
        minusZoom.snp.makeConstraints {
            $0.width.height.equalTo(46)
            $0.top.equalTo(plusZoom.snp.bottom).offset(10)
            $0.right.equalToSuperview().inset(12)
        }
        
        myLocation.snp.makeConstraints {
            $0.width.height.equalTo(46)
            $0.top.equalTo(minusZoom.snp.bottom).offset(10)
            $0.right.equalToSuperview().inset(12)
        }
    }
    
    private func setupViews() {
        [segmentedControlView, plusZoom, minusZoom, myLocation].forEach {
            view.addSubview($0)
        }
    }
    
    private func configureCoreMotion() {
        coreMotionService.startMotion()
        coreMotionService.delegate = self
    }
    
    private func configureLocationService() {
        locationService.delegate = self
    }
    
    private func binding() {
        viewModel.delegate = self
    }
}

// MARK: - Fetch
extension HomeViewController: DidUpdateDangerPointsDelegate {
    func didUpdateDangerPoints() {
        print(viewModel.dangerPoints)
    }
}
