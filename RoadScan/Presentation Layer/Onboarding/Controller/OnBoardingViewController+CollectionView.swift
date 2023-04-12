import UIKit

//MARK: - UICollectionViewDataSource
extension OnBoardingViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension OnBoardingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let viewCell: OnBoardingCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        let rows = sections[indexPath.section].rows[indexPath.row]
        viewCell.configure(with: OnBoardingCollectionViewCellViewModel(row: rows))
        viewCell.delegate = self
        
        return viewCell
    }
}
