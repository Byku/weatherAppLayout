import Foundation


func localized(key: String, comment: String = "") -> String {
    
    return NSLocalizedString(key, comment: comment)
}


extension String {
    
    func local(comment: String = "") -> String {
        
        return NSLocalizedString(self, comment: comment)
    }
}
