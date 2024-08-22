import UIKit

final class ViewController: UIViewController {
    // MARK: Properties
    private let button = UIButton(type: .system)
    let label = UILabel()
    private let nextVC = KakaoPostCodeVC()

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }

    // MARK: UI
    private func configureUI() {
        setAttributes()
        setContraints()
    }

    private func setAttributes() {
        button.setTitle("Button", for: .normal)
        button.addTarget(self, action: #selector(handlerButton(_:)), for: .touchUpInside)

        label.text = "label"
        label.font = UIFont.systemFont(ofSize: 20)
    }

    private func setContraints() {
        [button, label].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -40),
        ])
    }

    // MARK: Selector
    @objc
    private func handlerButton(_ sender: UIButton) {
        present(nextVC, animated: true)
    }
}
