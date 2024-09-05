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
        // Buttons
        view.addSubview(buttonsStackView)
        NSLayoutConstraint.activate([
            buttonsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
        ])
    }
}
