//
//  HomeViewModel.swift
//  RoadScan
//
//  Created by Tanirbergen Kaldibai on 08.04.2023.
//

import Foundation

protocol HomeViewModelInput {
    var dangerPoints: DangerZoneModel? { get set }
}

protocol HomeViewModelOutput {
    func fetchDangerPoints(detail: DangerZoneModel)
}

protocol DidUpdateDangerPointsDelegate: AnyObject {
    func didUpdateDangerPoints()
}

final class HomeViewModel: HomeViewModelInput {
    private let networkService: NetworkService
    var dangerPoints: DangerZoneModel?
    
    weak var delegate: DidUpdateDangerPointsDelegate?
    
    init(networkService: NetworkService = NetworkService()) {
        self.networkService = networkService
    }
}
  
extension HomeViewModel: HomeViewModelOutput {
    func fetchDangerPoints(detail: DangerZoneModel) {
        networkService.postDangerZone(param: detail) { [weak self] (response) in
            self?.dangerPoints = response
            self?.delegate?.didUpdateDangerPoints()
        }
    }
}
