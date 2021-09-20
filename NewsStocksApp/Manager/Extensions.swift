//
//  Extensions.swift
//  NewsStocksApp
//
//  Created by Anton Tuzov on 20.08.2021.
//

import UIKit


//    MARK: -  notification
extension Notification.Name {
    static let didAddToWotchList = Notification.Name ("didAddToWotchList")
 
}



//    MARK: -  numberFormatter
extension NumberFormatter {
    static let percentFormate: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = .current
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    
    static let numberFormate: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = .current
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    
}



//    MARK: - imageView
//
//extension UIImageView {
//    func setImage(with url: URL?) {
//        guard let url = url else {
//            return
//        }
//        DispatchQueue.global(qos: .userInteractive).async {
//            let task = URLSession.shared.dataTask(with: url) { [weak self]data, _, error in
//                guard let data = data, error == nil else {
//                    return
//                }
//                DispatchQueue.main.async {
//                    self?.image = UIImage(data: data)
//                }
//
//            }
//            task.resume()
//        }
//
//    }
//}







//    MARK: - String
extension String {
    static func string(from timeInterval: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timeInterval)
        return DateFormatter.prettyDateFormatter.string(from: date)
    }
    
    static func percentage(from double: Double) -> String {
        let formatter = NumberFormatter.percentFormate
        return formatter.string(from: NSNumber(value: double)) ?? "\(double)"
    }
    
    static func formatted(number: Double) -> String {
        let formatter = NumberFormatter.numberFormate
        return formatter.string(from: NSNumber(value: number)) ?? "\(number)"
    }
    
    
    
}






//    MARK: - DateFormat
extension DateFormatter {
    static let newsDateFormatter: DateFormatter = {
       let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
      return formatter
    }()
    
    static let prettyDateFormatter: DateFormatter = {
       let formatter = DateFormatter()
        formatter.dateStyle = .medium
      return formatter
    }()
    
    
    
}








//    MARK: - add subviews
extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach {
            addSubview($0)
            
        }
        
    }
    
    
}



extension UIView {
  
//    MARK: - Framing
    
    var width: CGFloat {
        frame.size.width
    }
    
    
    var height: CGFloat {
        frame.size.height
    }
    
    var left: CGFloat {
        frame.origin.x
    }
    
    var right: CGFloat {
        left + width
    }
    
    var top: CGFloat {
        frame.origin.y
    }
    
    var bottom: CGFloat {
        top + height
    }
    
    
    
    
    
}
