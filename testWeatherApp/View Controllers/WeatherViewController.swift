import UIKit

class WeatherViewController: UIViewController {

    let currentWeatherViewController = CurrentWeatherViewController()
    let weather = WeatherGenerator.weatherForecast()
    let tableView = UITableView()
    var hourlyWeatherCollectionView: UICollectionView!
    let scrollView = UIScrollView()
    var additionalWeatherLabels: [String] = []
    var scrollViewContentOffsetY: CGFloat = 0.0
    var currentWeatherHeightConstraint = NSLayoutConstraint()
    
    
    override func viewDidLoad() {
        addViews()
        addConstraints()
        fillWithData()
        
        // make bg gradient
        let bgGradient = CAGradientLayer()
        bgGradient.colors = [UIColor.blue.cgColor, UIColor.white.cgColor]
        bgGradient.locations = [0.0, 1.0]
        bgGradient.frame = view.frame
        view.layer.insertSublayer(bgGradient, at: 0)
    }
}


private extension WeatherViewController {
    
    func addViews() {
        addChildViewController(currentWeatherViewController)
        currentWeatherViewController.didMove(toParentViewController: self)
        view.addSubview(scrollView)
        view.addSubview(currentWeatherViewController.view)
        scrollView.addSubview(tableView)
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = false
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.isScrollEnabled = false
        tableView.allowsSelection = false
        tableView.backgroundColor = .clear
        tableView.register(UINib(nibName: "TemperatureTableViewCell", bundle: nil), forCellReuseIdentifier: "TemperatureTableViewCell")
        tableView.register(UINib(nibName: "TemperatureDailyForecastTableViewCell", bundle: nil), forCellReuseIdentifier: "TemperatureDailyForecastTableViewCell")
        
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        collectionViewLayout.minimumLineSpacing = 0
        collectionViewLayout.minimumInteritemSpacing = 0
        hourlyWeatherCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 100), collectionViewLayout: collectionViewLayout)
        hourlyWeatherCollectionView.dataSource = self
        hourlyWeatherCollectionView.delegate = self
        hourlyWeatherCollectionView.register(UINib(nibName: "HourlyWeatherCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HourlyWeatherCollectionViewCell")
        hourlyWeatherCollectionView.backgroundColor = .clear
        hourlyWeatherCollectionView.showsHorizontalScrollIndicator = false
        view.addSubview(hourlyWeatherCollectionView)
    }
    
    func addConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leftAnchor.constraint(equalTo: safeArea.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: safeArea.rightAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 170).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        
        currentWeatherViewController.view.translatesAutoresizingMaskIntoConstraints = false;
        currentWeatherViewController.view.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        currentWeatherViewController.view.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        currentWeatherViewController.view.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        
        var constraints = [NSLayoutConstraint]()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        hourlyWeatherCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        constraints.append(tableView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor))
        constraints.append(tableView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 180))
        constraints.append(tableView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor))
        constraints.append(tableView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor))
        constraints.append(tableView.widthAnchor.constraint(equalTo: scrollView.widthAnchor))
        constraints.append(tableView.heightAnchor.constraint(equalToConstant: 600))
        
        constraints.append(hourlyWeatherCollectionView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor))
        constraints.append(hourlyWeatherCollectionView.topAnchor.constraint(equalTo: currentWeatherViewController.view.bottomAnchor))
        constraints.append(hourlyWeatherCollectionView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor))
        constraints.append(hourlyWeatherCollectionView.heightAnchor.constraint(equalToConstant: 100))
        
        currentWeatherHeightConstraint = NSLayoutConstraint(item: currentWeatherViewController.view,
            attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 250)
        constraints.append(currentWeatherHeightConstraint)
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func fillWithData() {
        let calendar = Calendar.current
        let weekdays = calendar.weekdaySymbols
        let day = calendar.component(.weekday, from: weather.currentWeather.date) - 1
        currentWeatherViewController.day.text = weekdays[day].local()
        currentWeatherViewController.location.text = weather.currentWeather.location.local()
        currentWeatherViewController.cloudCover.text = weather.currentWeather.cloudCover.readableFormat()
        currentWeatherViewController.temperature.text = String(weather.currentWeather.temperature)
        currentWeatherViewController.today.text = "Today".local()
        currentWeatherViewController.tMax.text = String("\(weather.currentWeather.temperatureMax)°")
        currentWeatherViewController.tMin.text = String("\(weather.currentWeather.temperatureMin)°")
        
        let mirror = Mirror(reflecting: weather.currentWeather.additionalInfo)
        for child in mirror.children  {
            additionalWeatherLabels.append(child.label!)
        }
    }
    
    func getMetric(_ name:String) -> String {
        let prefix = "AdditionalInfo."
        let postfix = ".unit.metric"
        let metricKey = prefix + name + postfix
        let metric = metricKey.local()
        if metric == metricKey {
            return ""
        }
        return metric
    }
    
}


extension WeatherViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weather.hourlyWeather.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HourlyWeatherCollectionViewCell", for: indexPath) as! HourlyWeatherCollectionViewCell
        let cellData = weather.hourlyWeather[indexPath.row]
        cell.hourLabel?.text = String(Calendar.current.component(.hour, from: cellData.date))
        cell.weatherIcon.image = cellData.weatherIconType.image()
        cell.temperatureLabel?.text = String("\(cellData.temperature)°")
        return cell
    }
}

extension WeatherViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 100)
    }
}

extension WeatherViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return weather.dailyWeather.count
        default:
            return Mirror(reflecting: weather.currentWeather.additionalInfo).children.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let temperatureCell = tableView.dequeueReusableCell(withIdentifier: "TemperatureDailyForecastTableViewCell", for: indexPath) as! TemperatureDailyForecastTableViewCell
            let calendar = Calendar.current
            let weekdays = calendar.weekdaySymbols
            let cellData = weather.dailyWeather[indexPath.row]
            
            temperatureCell.dateLabel?.text = weekdays[calendar.component(Calendar.Component.weekday, from: cellData.date) - 1].local()
            temperatureCell.precipLabel?.text = String("\(cellData.precipProbability)%")
            temperatureCell.tMaxLabel?.text = String("\(cellData.temperatureMax)°")
            temperatureCell.tMinLabel?.text = String("\(cellData.temperatureMin)°")
            temperatureCell.weatherIconImageView.image = cellData.weatherIconType.image()
            
            return temperatureCell
        }
        let currentWeatherAdditionalCell = tableView.dequeueReusableCell(withIdentifier: "TemperatureTableViewCell", for: indexPath) as! TemperatureTableViewCell
        
        let mirror = Mirror(reflecting: weather.currentWeather.additionalInfo)
        for child in mirror.children {
            if String(child.label!) == additionalWeatherLabels[indexPath.row] {
                let labelName = additionalWeatherLabels[indexPath.row]
                currentWeatherAdditionalCell.titleLabel?.text = labelName.local()
            
                if type(of: child.value) == Date.self {
                    let calendar = Calendar.current
                    let hour = calendar.component(.hour, from: child.value as! Date)
                    let minutes = calendar.component(.minute, from: child.value as! Date)
                    currentWeatherAdditionalCell.valueLabel?.text = String("\(hour):\(minutes)")
                }
                else if type(of: child.value) == WindBearing.self {
                    currentWeatherAdditionalCell.valueLabel?.text = (child.value as! WindBearing).readableFormat()
                }
                else {
                    currentWeatherAdditionalCell.valueLabel?.text = String("\(child.value) \(getMetric(labelName))")
                }
            }
        }
        return currentWeatherAdditionalCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
}

extension WeatherViewController: UITableViewDelegate {
}

extension WeatherViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
         if type(of: scrollView) == UIScrollView.self {
            let offsetY = scrollView.contentOffset.y
            
            let newAlpha = (100 - offsetY * 2) * 0.01
            let noAlpha: CGFloat = 0
            let firstStepOffset: CGFloat = 40, secondStepOffset: CGFloat = 75
            currentWeatherViewController.temperature.alpha = offsetY < secondStepOffset ? newAlpha : noAlpha
            currentWeatherViewController.tMax.alpha = offsetY < firstStepOffset ? newAlpha : noAlpha
            currentWeatherViewController.tMin.alpha = offsetY < firstStepOffset ? newAlpha : noAlpha
            currentWeatherViewController.today.alpha = offsetY < firstStepOffset ? newAlpha : noAlpha
            currentWeatherViewController.day.alpha = offsetY < firstStepOffset ? newAlpha : noAlpha
        
            scrollViewContentOffsetY = offsetY
            currentWeatherHeightConstraint.constant = max(250 - offsetY, 70)
        }
    }
}
