import UIKit

final class GameVC: UIViewController {

    // MARK: - Properties

    // TODO: Add timer

    // MARK: - Views
    var stopwatchTimer: Timer?
    var elapsedTime: TimeInterval = 0
    var screenSize = UIScreen.main.bounds
    
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
            startGame(self.startButton)
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
        let layout = UICollectionViewFlowLayout()

        layout.minimumLineSpacing = 10 // Adjust spacing as needed
        layout.minimumInteritemSpacing = 10

        let gridCV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        gridCV.dataSource = self
        view.addSubview(gridCV)
        gridCV.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            gridCV.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            gridCV.topAnchor.constraint(equalTo: timeLabel.bottomAnchor),
            
            gridCV.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 50),
        ])
        gridCV.register(GridCollectionViewCell.self, forCellWithReuseIdentifier: "gridCell")
        
        // Buttons
        view.addSubview(buttonsStackView)
        NSLayoutConstraint.activate([
            buttonsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
        ])
    }
    
    //
    @IBAction func startGame(_ sender: UIButton) {
            // If the timer is running, stop it
        if let timer = stopwatchTimer {
                timer.invalidate()
                stopwatchTimer = nil
                elapsedTime = 0
                
                // Set the label to 0
                timeLabel.text = "00:00:00"
                
                // Update the button text
                sender.setTitle("Start", for: .normal)
            } else {
                // Start the timer
                stopwatchTimer = Timer.scheduledTimer(withTimeInterval: 0.001, repeats: true, block: { [weak self] timer in
                    // Update the elapsed time
                    self?.elapsedTime += timer.timeInterval
                    
                    // Format the elapsed time as a stopwatch time
                    let minutes = Int(self?.elapsedTime ?? 0) / 60 % 60
                    let seconds = Int(self?.elapsedTime ?? 0) % 60
                    let milliseconds = Int(self?.elapsedTime ?? 0 * 100)
                    print(milliseconds)
                    
                    // Update the label with the formatted time
                    self?.timeLabel.text = String(format: "%02d:%02d:%02d", minutes, seconds, milliseconds)
                })
                
                // Update the button text
                sender.setTitle("Stop", for: .normal)
            }
        }
}

extension GameVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        16
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gridCell", for: indexPath) as UICollectionViewCell? else {
            return UICollectionViewCell()
        }
        cell.backgroundColor = .black
        return cell
    }
}

extension GameVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
}

extension GameVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
}


