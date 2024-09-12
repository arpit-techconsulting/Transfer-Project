import UIKit

final class GameVC: UIViewController {

    // MARK: - Properties

    // TODO: Add timer

    // MARK: - Views
    
    private var imageNames = ["a", "b", "c", "d", "e", "f", "g", "h", "a", "b", "c", "d", "e", "f", "g", "h"]
    private var shuffledImgNames: [String] = [] // Created an empty array of imageNames
    private var gridData: [IndexPath: (imageName: String, isRevealed: Bool)] = [:]
    private var flippedIndexPaths: [IndexPath] = []
    private var totalPoints = 0

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
            let alertTitle = "Quit?"
            let alertMsg = "Are you sure you want to quit?"
            let alertVc = UIAlertController(title: alertTitle, message: alertMsg, preferredStyle: .alert)
            alertVc.addAction(UIAlertAction(title: "Quit", style: .destructive, handler: { _ in
                self?.navigationController?.popViewController(animated: true)
            }))
            alertVc.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self?.present(alertVc, animated: true, completion: nil)
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
        shuffledImgNames = imageNames.shuffled() // Randomizing the images and storing this to shuffledImgNames array
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
        return imageNames.count
    }
}

extension GameVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.frame.width / 4 - 20, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
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
        
        
        // Checking if the image is already avalaible in the gridData dictionary
        if let data = gridData[indexPath] {
            if data.isRevealed {
                return // If already revealed, then doing nothing
            }
    
            cell.imgView.image = UIImage(named: data.imageName)
            cell.backgroundColor = .clear
            gridData[indexPath]?.isRevealed = true
        } else {
            // Assigning a random image (if not revealed) to this cell and making the isRevealed to true
            let randomImageName = shuffledImgNames[indexPath.item]
            gridData[indexPath] = (imageName: randomImageName, isRevealed: true)
            cell.imgView.image = UIImage(named: randomImageName)
            cell.backgroundColor = .clear
        }
        
        print(gridData)
        
        // Adding the current cell to the flipped cells array
        flippedIndexPaths.append(indexPath)
        print(flippedIndexPaths)
        
        if flippedIndexPaths.count == 2 {
            let firstFlippedImgPath = flippedIndexPaths[0]
            let secondFlippedImgPath = flippedIndexPaths[1]
            
            if gridData[firstFlippedImgPath]?.imageName == gridData[secondFlippedImgPath]?.imageName {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    if let firstCell = collectionView.cellForItem(at: firstFlippedImgPath) as? CustomCollectionViewCell, let secondCell = collectionView.cellForItem(at: secondFlippedImgPath) as? CustomCollectionViewCell {
                        
                        firstCell.isHidden = true
                        secondCell.isHidden = true
                        
                        self.gridData[firstFlippedImgPath] = nil
                        self.gridData[secondFlippedImgPath] = nil
                        
                        self.totalPoints += 1
                        
                        if self.gridData.isEmpty {
                            let alertVc = UIAlertController(title: "Congratulations!", message: "You've matched all the images \n Total Points Earned: \(self.totalPoints)", preferredStyle: .alert)
                            alertVc.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            self.present(alertVc, animated: true, completion: nil)
                        }
                    }
                    
                    self.flippedIndexPaths.removeAll()
                }
            }
            
        }
        
        print(gridData)
        print(flippedIndexPaths)
    }
}
