import UIKit

final class HighScoresVC: UIViewController {

    private var collectionView: UICollectionView!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Methods

    private func setupUI() {
        title = "High Scores"
        view.backgroundColor = .systemBackground
        navigationItem.largeTitleDisplayMode = .never
    }
}
