import UIKit

final class HomeVC: UIViewController {

    // MARK: - Views

    private lazy var buttonsStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.addArrangedSubview(newGameButton)
        stackView.addArrangedSubview(highScoreButton)
        return stackView
    }()
    private lazy var newGameButton: UIButton = {
        var button = UIButton(configuration: .borderedProminent(),
                              primaryAction: UIAction(title: "New Game") { [weak self] _ in
            guard let self else { return }
            navigationController?.pushViewController(GameVC(), animated: true)
        })
        return button
    }()
    private lazy var highScoreButton: UIButton = {
        var button = UIButton(configuration: .borderedProminent(),
                              primaryAction: UIAction(title: "High Scores") { [weak self] _ in
            guard let self else { return }
            navigationController?.pushViewController(HighScoresVC(), animated: true)
        })
        return button
    }()
    private lazy var bylineLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.text = "By John Smith"
        return label
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Methods

    private func setupUI() {
        // Controller
        title = "Memory"
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        // Buttons
        view.addSubview(buttonsStackView)
        NSLayoutConstraint.activate([
            buttonsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        // Labels
        view.addSubview(bylineLabel)
        NSLayoutConstraint.activate([
            bylineLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bylineLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
        ])
    }
}

