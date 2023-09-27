import Foundation

extension String {
    
    func toDate(with format: String? = "yyyy-MM-dd") -> Date? {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.locale = Locale.current
        formatter.dateFormat = format
        return formatter.date(from: self)
    }
    
}
