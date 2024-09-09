import UIKit

final class GameVC: UIViewController {

    // MARK: - Properties

    // TODO: Add timer

    // MARK: - Views

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
}
