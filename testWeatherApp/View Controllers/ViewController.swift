import UIKit

class ViewController: UIViewController {
    private let weatherViewController = WeatherViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayContentController(weatherViewController)
    }
}

private extension ViewController {
    func displayContentController(_ content: UIViewController) {
        addChildViewController(content)
        view.addSubview(content.view)
        frameForWeatherController()
        content.didMove(toParentViewController: self)
    }
    
    func frameForWeatherController() {
        weatherViewController.view.translatesAutoresizingMaskIntoConstraints = false
        weatherViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        weatherViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        weatherViewController.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        weatherViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
