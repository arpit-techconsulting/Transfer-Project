import UIKit

final class GameVC: UIViewController {

    // MARK: - Properties

    // TODO: Add timer

    // MARK: - Views
    
    private let imageNames = ["a", "b", "c", "d", "e", "f", "g", "h", "a", "b", "c", "d", "e", "f", "g", "h"]
    private var gridData: [IndexPath: (imageName: String, isRevealed: Bool)] = [:]
    private var flippedIndexPaths: [IndexPath] = []

    private lazy var timeLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = .monospacedSystemFont(ofSize: 24, weight: .bold)
        label.text = "00:00:00"
        return label
    }()
    private lazy var buttonsStackView: UIStackView = {
        var stackView = UIStackView(arrangedSubviews: [quitButton, startButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 20
        return stackView
    }()
    private lazy var startButton: UIButton = {
        var button = UIButton(configuration: .borderedProminent(),
                              primaryAction: UIAction(title: "Start") { [weak self] _ in
            guard let self else { return }
            print("TODO: Start Game")
        })
        return button
    }()
    private lazy var quitButton: UIButton = {
        var button = UIButton(configuration: .borderedProminent(),
                              primaryAction: UIAction(title: "Quit") { [weak self] _ in
            guard let self else { return }
            navigationController?.popViewController(animated: true)
        })
        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Methods

    private func setupUI() {
        view.backgroundColor = .systemBackground
        collectionView.dataSource = self
        collectionView.delegate = self
        navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Info",
                                                            image: UIImage(systemName: "info.circle.fill"),
                                                            primaryAction: UIAction(handler: { _ in
            // Help Alert
            let alertTitle = "How To"
            let alertMessage = "Tap a square to flip it.\nIf you flip two squares and they match, you score a point.\nThe game ends when you find all matches."
            let alertVC = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }))
        // Label
        view.addSubview(timeLabel)
        NSLayoutConstraint.activate([
            timeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timeLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
        // Buttons
        view.addSubview(buttonsStackView)
        NSLayoutConstraint.activate([
            buttonsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        // Collection View
        self.view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10.0),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10.0),
            collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            collectionView.heightAnchor.constraint(equalTo: collectionView.widthAnchor)
        ])
    }
}

extension GameVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CustomCollectionViewCell
        cell?.backgroundColor = .gray
        return cell ?? CustomCollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 16
    }
}

extension GameVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.frame.width / 4 - 20, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(flippedIndexPaths)
        
        if flippedIndexPaths.count == 2 {
            // Flipping the first two back to original state
            for path in flippedIndexPaths {
                if let cell = collectionView.cellForItem(at: path) as? CustomCollectionViewCell {
                    cell.imgView.image = nil
                    cell.backgroundColor = .gray
                    
                    gridData[path]?.isRevealed = false
                }
            }
            // Clearing the flipped cells array when there are 2 elements in the array
            flippedIndexPaths.removeAll()
        }
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? CustomCollectionViewCell else { return }
        print(gridData)
        
        // Checking if the image has already been assigned to the cell
        if let data = gridData[indexPath] {
            if data.isRevealed {
                return // If already revealed, doing nothing
            }
    
            cell.imgView.image = UIImage(named: data.imageName)
            cell.backgroundColor = .clear
            gridData[indexPath]?.isRevealed = true
        } else {
            // Assigning a random image (if not revealed) to this cell and making the isRevealed to true
            let randomImageName = imageNames.randomElement() ?? "defaultImage"
            gridData[indexPath] = (imageName: randomImageName, isRevealed: true)
            cell.imgView.image = UIImage(named: randomImageName)
            cell.backgroundColor = .clear
        }
        
        // Adding the current cell to the flipped cells array
        flippedIndexPaths.append(indexPath)
    }
}
