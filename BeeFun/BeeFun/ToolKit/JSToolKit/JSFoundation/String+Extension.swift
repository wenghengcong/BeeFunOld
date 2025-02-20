//
//  String+Extension.swift
//  LoveYou
//
//  Created by WengHengcong on 2017/3/12.
//  Copyright © 2017年 JungleSong. All rights reserved.
//

import UIKit

// MARK: - Localized
extension String {

    //http://stackoverflow.com/questions/25081757/whats-nslocalizedstring-equivalent-in-swift
    //https://github.com/nixzhu/dev-blog/blob/master/2014-04-24-internationalization-tutorial-for-ios-2014.md

    /// 获取APP语言字符串
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.appBundle, value: "", comment: "")
    }

    /// 获取英文国际化字符串
    var enLocalized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.enBundle, value: "", comment: "")
    }

    /// 获取中文国际化字符串
    var cnLocalized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.cnBundle, value: "", comment: "")
    }

    /// 获取APP语言字符串
    func localized(withComment: String) -> String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.appBundle, value: "", comment: withComment)
    }

    /// 获取英文国际化字符串
    func enLocalized(withComment: String) -> String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.enBundle, value: "", comment: withComment)
    }

    /// 获取中文国际化字符串
    func cnLocalized(withComment: String) -> String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.cnBundle, value: "", comment: withComment)
    }

}

// MARK: - count
extension String {
    /// 字符串长度
    var length: Int {
        return characters.count
    }

    /// 按UTF16标准的字符串长度
    var utf16Length: Int {
        return self.utf16.count
    }

    // MARK: - index

    /// 返回Index类型
    ///
    /// - Parameter from: <#from description#>
    /// - Returns: <#return value description#>
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
}

// MARK: - substring
extension String {
    //http://stackoverflow.com/questions/39677330/how-does-string-substring-work-in-swift-3

    /// 裁剪字符串from
    ///
    /// - Parameter from: <#from description#>
    /// - Returns: <#return value description#>
    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return substring(from: fromIndex)
    }

    /// 裁剪字符串to
    ///
    /// - Parameter to: <#to description#>
    /// - Returns: <#return value description#>
    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return substring(to: toIndex)
    }

    /// 裁剪字符串range
    ///
    /// - Parameter r: <#r description#>
    /// - Returns: <#return value description#>
    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return substring(with: startIndex..<endIndex)
    }
}

extension String {

    /// 随机字符串，包含大小写字母、数字
    ///
    /// - Parameter length: 长度应小于62
    /// - Returns: <#return value description#>
    static func randomCharsNums(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return random(length: length, letters: letters)
    }

    /// 随机字符串，只包含大小写字母
    ///
    /// - Parameter length: 长度应小于52
    /// - Returns: <#return value description#>
    static func randomChars(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        return random(length: length, letters: letters)
    }

    /// 随机字符串，只包含数字
    ///
    /// - Parameter length: 长度应小于10
    static func randomNums(length: Int) -> String {
        let letters = "0123456789"
        return random(length: length, letters: letters)
    }

    /// 随机字符串
    ///
    /// - Parameters:
    ///   - length: 生成的字符串长度
    ///   - letters: 用语生成随机字符串的字符串数据集
    /// - Returns: <#return value description#>
    static func random(length: Int, letters: String) -> String {
        let len = UInt32(letters.length)
        var randomString = ""
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            let nextCharIndex = letters.index(letters.startIndex, offsetBy: Int(rand))
            let nextChar = String(letters[nextCharIndex])
            randomString += nextChar
        }

        return randomString
    }
}

#if os(macOS)
    import Cocoa
#else
    import UIKit
#endif

// MARK: - Properties
public extension String {
    
    /// SwifterSwift: String decoded from base64 (if applicable).
    public var base64Decoded: String? {
        // https://github.com/Reza-Rg/Base64-Swift-Extension/blob/master/Base64.swift
        guard let decodedData = Data(base64Encoded: self) else {
            return nil
        }
        return String(data: decodedData, encoding: .utf8)
    }
    
    /// SwifterSwift: String encoded in base64 (if applicable).
    public var base64Encoded: String? {
        // https://github.com/Reza-Rg/Base64-Swift-Extension/blob/master/Base64.swift
        let plainData = data(using: .utf8)
        return plainData?.base64EncodedString()
    }
    
    /// SwifterSwift: Array of characters of a string.
    public var charactersArray: [Character] {
        return Array(characters)
    }
    
    /// SwifterSwift: CamelCase of string.
    public var camelCased: String {
        let source = lowercased()
        if source.characters.contains(" ") {
            let first = source.substring(to: source.index(after: source.startIndex))
            let camel = source.capitalized.replacing(" ", with: "").replacing("\n", with: "")
            let rest = String(camel.characters.dropFirst())
            return first + rest
        }
        
        let first = source.lowercased().substring(to: source.index(after: source.startIndex))
        let rest = String(source.characters.dropFirst())
        return first + rest
    }
    
    /// SwifterSwift: Check if string contains one or more emojis.
    public var containEmoji: Bool {
        // http://stackoverflow.com/questions/30757193/find-out-if-character-in-string-is-emoji
        for scalar in unicodeScalars {
            switch scalar.value {
            case 0x3030, 0x00AE, 0x00A9, // Special Characters
            0x1D000...0x1F77F, // Emoticons
            0x2100...0x27BF, // Misc symbols and Dingbats
            0xFE00...0xFE0F, // Variation Selectors
            0x1F900...0x1F9FF: // Supplemental Symbols and Pictographs
                return true
            default:
                continue
            }
        }
        return false
    }
    
    /// SwifterSwift: First character of string (if applicable).
    public var firstCharacter: String? {
        guard let first = characters.first else {
            return nil
        }
        return String(first)
    }
    
    /// SwifterSwift: Check if string contains one or more letters.
    public var hasLetters: Bool {
        return rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
    }
    
    /// SwifterSwift: Check if string contains one or more numbers.
    public var hasNumbers: Bool {
        return rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
    }
    
    /// SwifterSwift: Check if string contains only letters.
    public var isAlphabetic: Bool {
        return hasLetters && !hasNumbers
    }
    
    /// SwifterSwift: Check if string contains at least one letter and one number.
    public var isAlphaNumeric: Bool {
        return components(separatedBy: CharacterSet.alphanumerics).joined(separator: "").characters.count == 0 && hasLetters && hasNumbers
    }
    
    /// SwifterSwift: Check if string is valid email format.
    public var isEmail: Bool {
        // http://stackoverflow.com/questions/25471114/how-to-validate-an-e-mail-address-in-swift
        return matches(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}")
    }
    
    /// SwifterSwift: Check if string is a valid URL.
    public var isValidUrl: Bool {
        return URL(string: self) != nil
    }
    
    /// SwifterSwift: Check if string is a valid schemed URL.
    public var isValidSchemedUrl: Bool {
        guard let url = URL(string: self) else {
            return false
        }
        return url.scheme != nil
    }
    
    /// SwifterSwift: Check if string is a valid https URL.
    public var isValidHttpsUrl: Bool {
        guard let url = URL(string: self) else {
            return false
        }
        return url.scheme == "https"
    }
    
    /// SwifterSwift: Check if string is a valid http URL.
    public var isValidHttpUrl: Bool {
        guard let url = URL(string: self) else {
            return false
        }
        return url.scheme == "http"
    }
    
    /// SwifterSwift: Check if string contains only numbers.
    public var isNumeric: Bool {
        return  !hasLetters && hasNumbers
    }
    
    /// Check if string contains only digits.
    public var isOnlyNumeric: Bool {
        //remove . symbol ,because some number written "1,000" or "1,000,000"
        let removeDot = self.replacing(",", with: "")
        let onlyDigits: CharacterSet = CharacterSet.decimalDigits.inverted
        if removeDot.rangeOfCharacter(from: onlyDigits) == nil {
            // String only consist digits 0-9
            return true
        }
        return false
    }
    
    /// SwifterSwift: Last character of string (if applicable).
    public var lastCharacter: String? {
        guard let last = characters.last else {
            return nil
        }
        return String(last)
    }
    
    /// SwifterSwift: Latinized string.
    public var latinized: String {
        return folding(options: .diacriticInsensitive, locale: Locale.current)
    }

    /// SwifterSwift: Array of strings separated by new lines.
    public var lines: [String] {
        var result = [String]()
        enumerateLines { line, _ in
            result.append(line)
        }
        return result
    }
    
    /// SwifterSwift: The most common character in string.
    public var mostCommonCharacter: String {
        let mostCommon = withoutSpacesAndNewLines.characters.reduce([Character: Int]()) {
            var counts = $0
            counts[$1] = ($0[$1] ?? 0) + 1
            return counts
            }.max { $0.1 < $1.1 }?.0
        return mostCommon?.string ?? ""
    }
    
    /// SwifterSwift: Reversed string.
    public var reversed: String {
        return String(characters.reversed())
    }
    
    /// SwifterSwift: Bool value from string (if applicable).
    public var bool: Bool? {
        let selfLowercased = trimmed.lowercased()
        switch selfLowercased {
        case "True", "true", "yes", "1":
            return true
        case "False", "false", "no", "0":
            return false
        default:
            return nil
        }
    }
    
    /// SwifterSwift: Date object from "yyyy-MM-dd" formatted string
    public var date: Date? {
        let selfLowercased = trimmed.lowercased()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: selfLowercased)
    }
    
    /// SwifterSwift: Date object from "yyyy-MM-dd HH:mm:ss" formatted string.
    public var dateTime: Date? {
        let selfLowercased = trimmed.lowercased()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.date(from: selfLowercased)
    }
    
    /// SwifterSwift: Double value from string (if applicable).
    public var double: Double? {
        let formatter = NumberFormatter()
        return formatter.number(from: self) as? Double
    }
    
    /// SwifterSwift: Float value from string (if applicable).
    public var float: Float? {
        let formatter = NumberFormatter()
        return formatter.number(from: self) as? Float
    }
    
    /// SwifterSwift: Float32 value from string (if applicable).
    public var float32: Float32? {
        let formatter = NumberFormatter()
        return formatter.number(from: self) as? Float32
    }
    
    /// SwifterSwift: Float64 value from string (if applicable).
    public var float64: Float64? {
        let formatter = NumberFormatter()
        return formatter.number(from: self) as? Float64
    }
    
    /// SwifterSwift: Integer value from string (if applicable).
    public var int: Int? {
        return Int(self)
    }
    
    /// SwifterSwift: Int16 value from string (if applicable).
    public var int16: Int16? {
        return Int16(self)
    }
    
    /// SwifterSwift: Int32 value from string (if applicable).
    public var int32: Int32? {
        return Int32(self)
    }
    
    /// SwifterSwift: Int64 value from string (if applicable).
    public var int64: Int64? {
        return Int64(self)
    }
    
    /// SwifterSwift: Int8 value from string (if applicable).
    public var int8: Int8? {
        return Int8(self)
    }
    
    /// SwifterSwift: URL from string (if applicable).
    public var url: URL? {
        return URL(string: self)
    }
    
    /// SwifterSwift: String with no spaces or new lines in beginning and end.
    public var trimmed: String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    /// SwifterSwift: Array with unicodes for all characters in a string.
    public var unicodeArray: [Int] {
        return unicodeScalars.map({$0.hashValue})
    }
    
    /// SwifterSwift: Readable string from a URL string.
    public var urlDecoded: String {
        return removingPercentEncoding ?? self
    }
    
    /// SwifterSwift: URL escaped string.
    public var urlEncoded: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    /// SwifterSwift: String without spaces and new lines.
    public var withoutSpacesAndNewLines: String {
        return replacing(" ", with: "").replacing("\n", with: "")
    }
    
}

// MARK: - Methods
public extension String {
    
    /// SwifterSwift: Safely subscript string with index.
    ///
    /// - Parameter i: index.
    public subscript(i: Int) -> String? {
        guard i >= 0 && i < characters.count else {
            return nil
        }
        return String(self[index(startIndex, offsetBy: i)])
    }

    
    #if os(iOS) || os(macOS)
    /// SwifterSwift: Copy string to global pasteboard.
    public func copyToPasteboard() {
        #if os(iOS)
            UIPasteboard.general.string = self
        #elseif os(macOS)
            NSPasteboard.general().clearContents()
            NSPasteboard.general().setString(self, forType: NSPasteboardTypeString)
        #endif
    }
    #endif
    
    /// SwifterSwift: Converts string format to CamelCase.
    public mutating func camelize() {
        self = camelCased
    }
    
    /// SwifterSwift: Check if string contains one or more instance of substring.
    ///
    /// - Parameters:
    ///   - string: substring to search for.
    ///   - caseSensitive: set true for case sensitive search (default is true).
    /// - Returns: true if string contains one or more instance of substring.
    public func contains(_ string: String, caseSensitive: Bool = true) -> Bool {
        if !caseSensitive {
            return range(of: string, options: .caseInsensitive) != nil
        }
        return range(of: string) != nil
    }
    
    /// SwifterSwift: Count of substring in string.
    ///
    /// - Parameters:
    ///   - string: substring to search for.
    ///   - caseSensitive: set true for case sensitive search (default is true).
    /// - Returns: count of appearance of substring in string.
    public func count(of string: String, caseSensitive: Bool = true) -> Int {
        if !caseSensitive {
            return lowercased().components(separatedBy: string.lowercased()).count - 1
        }
        return components(separatedBy: string).count - 1
    }
    
    /// SwifterSwift: Check if string ends with substring.
    ///
    /// - Parameters:
    ///   - suffix: substring to search if string ends with.
    ///   - caseSensitive: set true for case sensitive search (default is true).
    /// - Returns: true if string ends with substring.
    public func ends(with suffix: String, caseSensitive: Bool = true) -> Bool {
        if !caseSensitive {
            return lowercased().hasSuffix(suffix.lowercased())
        }
        return hasSuffix(suffix)
    }
    
    /// SwifterSwift: First index of substring in string.
    ///
    /// - Parameter string: substring to search for.
    /// - Returns: first index of substring in string (if applicable).
    public func firstIndex(of string: String) -> Int? {
        return Array(characters).map({String($0)}).index(of: string)
    }
    
    /// SwifterSwift: Latinize string.
    public mutating func latinize() {
        self = latinized
    }
    
    /// SwifterSwift: String by replacing part of string with another string.
    ///
    /// - Parameters:
    ///   - substring: old substring to find and replace.
    ///   - newString: new string to insert in old string place.
    /// - Returns: string after replacing substring with newString.
    public func replacing(_ substring: String, with newString: String) -> String {
        return replacingOccurrences(of: substring, with: newString)
    }
    
    /// SwifterSwift: Reverse string.
    public mutating func reverse() {
        self = String(characters.reversed())
    }

    /// SwifterSwift: Array of strings separated by given string.
    ///
    /// - Parameter separator: separator to split string by.
    /// - Returns: array of strings separated by given string.
    public func splitted(by separator: Character) -> [String] {
        return characters.split{$0 == separator}.map(String.init)
    }
    
    /// SwifterSwift: Check if string starts with substring.
    ///
    /// - Parameters:
    ///   - suffix: substring to search if string starts with.
    ///   - caseSensitive: set true for case sensitive search (default is true).
    /// - Returns: true if string starts with substring.
    public func starts(with prefix: String, caseSensitive: Bool = true) -> Bool {
        if !caseSensitive {
            return lowercased().hasPrefix(prefix.lowercased())
        }
        return hasPrefix(prefix)
    }
    
    /// SwifterSwift: Date object from string of date format.
    ///
    /// - Parameter format: date format.
    /// - Returns: Date object from string (if applicable).
    public func date(withFormat format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }
    
    /// SwifterSwift: Removes spaces and new lines in beginning and end of string.
    public mutating func trim() {
        self = trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    /// SwifterSwift: Truncate string (cut it to a given number of characters).
    ///
    /// - Parameters:
    ///   - toLength: maximum number of characters before cutting.
    ///   - trailing: string to add at the end of truncated string (default is "...").
    public mutating func truncate(toLength: Int, trailing: String? = "...") {
        guard toLength > 0 else {
            return
        }
        if characters.count > toLength {
            self = substring(to: index(startIndex, offsetBy: toLength)) + (trailing ?? "")
        }
    }
    
    /// SwifterSwift: Truncated string (limited to a given number of characters).
    ///
    /// - Parameters:
    ///   - toLength: maximum number of characters before cutting.
    ///   - trailing: string to add at the end of truncated string.
    /// - Returns: truncated string (this is an extr...).
    public func truncated(toLength: Int, trailing: String? = "...") -> String {
        guard 1..<characters.count ~= toLength else { return self }
        return substring(to: index(startIndex, offsetBy: toLength)) + (trailing ?? "")
    }
    
    /// SwifterSwift: Convert URL string to readable string.
    public mutating func urlDecode() {
        if let decoded = removingPercentEncoding {
            self = decoded
        }
    }
    
    /// SwifterSwift: Escape string.
    public mutating func urlEncode() {
        if let encoded = addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
            self = encoded
        }
    }
    
    /// SwifterSwift: Verify if string matches the regex pattern.
    ///
    /// - Parameter pattern: Pattern to verify.
    /// - Returns: true if string matches the pattern.
    func matches(pattern: String) -> Bool {
        return range(of: pattern,
                     options: String.CompareOptions.regularExpression,
                     range: nil, locale: nil) != nil
    }
    
}

// MARK: - Operators
public extension String {
    
    /// SwifterSwift: Repeat string multiple times.
    ///
    /// - Parameters:
    ///   - lhs: string to repeat.
    ///   - rhs: number of times to repeat character.
    /// - Returns: new string with given string repeated n times.
    public static func * (lhs: String, rhs: Int) -> String {
        guard rhs > 0 else {
            return ""
        }
        return String(repeating: lhs, count: rhs)
    }
    
    /// SwifterSwift: Repeat string multiple times.
    ///
    /// - Parameters:
    ///   - lhs: number of times to repeat character.
    ///   - rhs: string to repeat.
    /// - Returns: new string with given string repeated n times.
    public static func * (lhs: Int, rhs: String) -> String {
        guard lhs > 0 else {
            return ""
        }
        return String(repeating: rhs, count: lhs)
    }
    
}

// MARK: - Initializers
public extension String {
    
    /// SwifterSwift: Create a new string from a base64 string (if applicable).
    ///
    /// - Parameter base64: base64 string.
    public init?(base64: String) {
        guard let str = base64.base64Decoded else {
            return nil
        }
        self.init(str)
    }
    
}

// MARK: - NSAttributedString extensions
public extension String {
    
    #if !os(tvOS) && !os(watchOS)
    /// SwifterSwift: Bold string.
    public var bold: NSAttributedString {
        #if os(macOS)
            return NSMutableAttributedString(string: self, attributes: [NSFontAttributeName: NSFont.boldSystemFont(ofSize: NSFont.systemFontSize())])
        #else
            return NSMutableAttributedString(string: self, attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)])
        #endif
    }
    #endif
    
    /// SwifterSwift: Underlined string
    public var underline: NSAttributedString {
        return NSAttributedString(string: self, attributes: [NSAttributedStringKey.underlineStyle: NSUnderlineStyle.styleSingle.rawValue])
    }
    
    /// SwifterSwift: Strikethrough string.
    public var strikethrough: NSAttributedString {
        return NSAttributedString(string: self, attributes: [NSAttributedStringKey.strikethroughStyle: NSNumber(value: NSUnderlineStyle.styleSingle.rawValue as Int)])
    }
    
    #if os(iOS)
    /// SwifterSwift: Italic string.
    public var italic: NSAttributedString {
        return NSMutableAttributedString(string: self, attributes: [NSAttributedStringKey.font: UIFont.italicSystemFont(ofSize: UIFont.systemFontSize)])
    }
    #endif
    
    #if os(macOS)
    /// SwifterSwift: Add color to string.
    ///
    /// - Parameter color: text color.
    /// - Returns: a NSAttributedString versions of string colored with given color.
    public func colored(with color: NSColor) -> NSAttributedString {
    return NSMutableAttributedString(string: self, attributes: [NSForegroundColorAttributeName: color])
    }
    #else
    /// SwifterSwift: Add color to string.
    ///
    /// - Parameter color: text color.
    /// - Returns: a NSAttributedString versions of string colored with given color.
    public func colored(with color: UIColor) -> NSAttributedString {
        return NSMutableAttributedString(string: self, attributes: [NSAttributedStringKey.foregroundColor: color])
    }
    #endif
    
}

//MARK: - NSString extensions
public extension String {
    
    /// SwifterSwift: NSString from a string.
    public var nsString: NSString {
        return NSString(string: self)
    }
    
    /// SwifterSwift: NSString lastPathComponent.
    public var lastPathComponent: String {
        return (self as NSString).lastPathComponent
    }
    
    /// SwifterSwift: NSString pathExtension.
    public var pathExtension: String {
        return (self as NSString).pathExtension
    }
    
    /// SwifterSwift: NSString deletingLastPathComponent.
    public var deletingLastPathComponent: String {
        return (self as NSString).deletingLastPathComponent
    }
    
    /// SwifterSwift: NSString deletingPathExtension.
    public var deletingPathExtension: String {
        return (self as NSString).deletingPathExtension
    }
    
    /// SwifterSwift: NSString pathComponents.
    public var pathComponents: [String] {
        return (self as NSString).pathComponents
    }
    
    /// SwifterSwift: NSString appendingPathComponent(str: String)
    ///
    /// - Parameter str: the path component to append to the receiver.
    /// - Returns: a new string made by appending aString to the receiver, preceded if necessary by a path separator.
    public func appendingPathComponent(_ str: String) -> String {
        return (self as NSString).appendingPathComponent(str)
    }
    
    /// SwifterSwift: NSString appendingPathExtension(str: String)
    ///
    /// - Parameter str: The extension to append to the receiver.
    /// - Returns: a new string made by appending to the receiver an extension separator followed by ext (if applicable).
    public func appendingPathExtension(_ str: String) -> String? {
        return (self as NSString).appendingPathExtension(str)
    }
}

extension String {
    
    /// EZSE: Checks if string is empty or consists only of whitespace and newline characters
    public var isBlank: Bool {
        let trimmed = trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed.isEmpty
    }
    
    /// EZSE: split string using a spearator string, returns an array of string
    public func split(_ separator: String) -> [String] {
        return self.components(separatedBy: separator).filter {
            !$0.trimmed.isEmpty
        }
    }
    
    /// EZSE: split string with delimiters, returns an array of string
    public func split(_ characters: CharacterSet) -> [String] {
        return self.components(separatedBy: characters).filter {
            !$0.trimmed.isEmpty
        }
    }
    
    
    /// EZSE: Returns if String is a number
    public func isNumber() -> Bool {
        if let _ = NumberFormatter().number(from: self) {
            return true
        }
        return false
    }
    
    /// EZSE: Extracts URLS from String
    public var extractURLs: [URL] {
        var urls: [URL] = []
        let detector: NSDataDetector?
        do {
            detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        } catch _ as NSError {
            detector = nil
        }
        
        let text = self
        
        if let detector = detector {
            detector.enumerateMatches(in: text, options: [], range: NSRange(location: 0, length: text.characters.count), using: {
                (result: NSTextCheckingResult?, flags: NSRegularExpression.MatchingFlags, stop: UnsafeMutablePointer<ObjCBool>) -> Void in
                if let result = result, let url = result.url {
                    urls.append(url)
                }
            })
        }
        
        return urls
    }
    
    /// EZSE: Checking if String contains input with comparing options
    public func contains(_ find: String, compareOption: NSString.CompareOptions) -> Bool {
        return self.range(of: find, options: compareOption) != nil
    }
    
    #if os(iOS)
    
    /// EZSE: copy string to pasteboard
    public func addToPasteboard() {
        let pasteboard = UIPasteboard.general
        pasteboard.string = self
    }
    
    #endif
    
    /// EZSE: Checks if String contains Emoji
    public func includesEmoji() -> Bool {
        for i in 0...length {
            let c: unichar = (self as NSString).character(at: i)
            if (0xD800 <= c && c <= 0xDBFF) || (0xDC00 <= c && c <= 0xDFFF) {
                return true
            }
        }
        return false
    }
}
extension String {
    init(_ value: Float, precision: Int) {
        let nFormatter = NumberFormatter()
        nFormatter.numberStyle = .decimal
        nFormatter.maximumFractionDigits = precision
        self = nFormatter.string(from: NSNumber(value: value))!
    }
    
    init(_ value: Double, precision: Int) {
        let nFormatter = NumberFormatter()
        nFormatter.numberStyle = .decimal
        nFormatter.maximumFractionDigits = precision
        self = nFormatter.string(from: NSNumber(value: value))!
    }
}
/// EZSE: Pattern matching of strings via defined functions
public func ~=<T> (pattern: ((T) -> Bool), value: T) -> Bool {
    return pattern(value)
}

/// EZSE: Can be used in switch-case
public func hasPrefix(_ prefix: String) -> (_ value: String) -> Bool {
    return { (value: String) -> Bool in
        value.hasPrefix(prefix)
    }
}

/// EZSE: Can be used in switch-case
public func hasSuffix(_ suffix: String) -> (_ value: String) -> Bool {
    return { (value: String) -> Bool in
        value.hasSuffix(suffix)
    }
}

extension String {
    var numbers: String {
        return String(characters.filter { "0"..."9" ~= $0 })
    }
}
