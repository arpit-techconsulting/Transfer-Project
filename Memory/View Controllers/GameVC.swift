import UIKit
import Combine

final class GameVC: UIViewController {

    var timerCancellable: AnyCancellable?
    let gameVM = GameViewModel()
    
    // MARK: - Properties

    // MARK: - Views
    lazy var gridView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cellSize = view.safeAreaLayoutGuide.layoutFrame.width / 6
        layout.itemSize = CGSize(width: cellSize, height: cellSize)
        let gv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        gv.translatesAutoresizingMaskIntoConstraints = false
        gv.register(GridCollectionViewCell.self, forCellWithReuseIdentifier: "gridCell")
        return gv
    }()
    
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
            gameVM.startGame()
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

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        timerCancellable = gameVM.$elapsedTime.sink(receiveValue: { _ in
            self.timeLabel.text = self.gameVM.timeFormat()
        })
    }

    // MARK: - Methods
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Info",
                                                            image: UIImage(systemName: "info.circle.fill"),
                                                            primaryAction: UIAction(handler: { _ in
            print("TODO: Show Instructions")
        }))
        // Label
        view.addSubview(timeLabel)
        NSLayoutConstraint.activate([
            timeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timeLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        ])
        
        //Grid
        gridView.dataSource = self
        gridView.delegate = self
        view.addSubview(gridView)
        
        NSLayoutConstraint.activate([
            gridView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            gridView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            gridView.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 20),
            
            gridView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 50),
            
        ])
        
        // Buttons
        view.addSubview(buttonsStackView)
        NSLayoutConstraint.activate([
            buttonsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
        ])
    }
}

extension GameVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        16
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gridCell", for: indexPath) as? GridCollectionViewCell else {
            return GridCollectionViewCell()
        }
        cell.backgroundColor = .black
        return cell
    }
}

extension GameVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = gridView.dequeueReusableCell(withReuseIdentifier:
     "gridCell", for: indexPath) as? GridCollectionViewCell else { return }
        cell.showImage()
        //gridView.reloadData()
    }
}

extension GameVC: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
//     "gridCell", for: indexPath) as? GridCollectionViewCell else { return }
//        cell.showImage(imgsArr: imgsArr, itemIndex: indexPath.item)
//        gridView?.reloadData()
//    }
}
