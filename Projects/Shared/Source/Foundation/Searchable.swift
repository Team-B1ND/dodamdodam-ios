//
//  KoreanStringSearchHelper.swift
//  Shared
//
//  Created by hhhello0507 on 2/4/25.
//

public protocol Searchable: Equatable {
    var searchText: String { get }
}

public extension Array where Element: Searchable {
    func search(text: String) -> Self {
        let helper = KoreanStringSearchHelper(data: self)
        return helper.getMatchedDatas(text: text)
    }
}

final class KoreanStringSearchHelper<Element: Searchable> {
    let hangle = [
        ["ㄱ", "ㄲ", "ㄴ", "ㄷ", "ㄸ", "ㄹ", "ㅁ", "ㅂ", "ㅃ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅉ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"],
        ["ㅏ", "ㅐ", "ㅑ", "ㅒ", "ㅓ", "ㅔ", "ㅕ", "ㅖ", "ㅗ", "ㅘ", "ㅙ", "ㅚ", "ㅛ", "ㅜ", "ㅝ", "ㅞ", "ㅟ", "ㅠ", "ㅡ", "ㅢ", "ㅣ"],
        ["", "ㄱ", "ㄲ", "ㄳ", "ㄴ", "ㄵ", "ㄶ", "ㄷ", "ㄹ", "ㄺ", "ㄻ", "ㄼ", "ㄽ", "ㄾ", "ㄿ", "ㅀ", "ㅁ", "ㅂ", "ㅄ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"]
    ]
    
    private var filteredData: [Element]!
    private var dataArray: [Element]!
    
    private var initialMatching: Bool = true
    private var partialMatching: Bool = true
    
    public init(data: [Element]) {
        dataArray = data
    }
    
    public func setInitialMatching(value: Bool) {
        self.initialMatching = value
    }
    
    public func setPartialMatching(value: Bool) {
        self.partialMatching = value
    }
    
    public func getMatchedDatas(text: String) -> [Element] {
        if text.isEmpty || dataArray.isEmpty {
            return dataArray
        }
        
        filteredData = []
        
        var idxSetPriority = Set<Int>()
        
        if isOnlyInitial(word: text) {
            if initialMatching {
                for index in 0...(dataArray.count - 1) {
                    let convertedData = convertToInitial(word: dataArray[index].searchText)
                    
                    if convertedData.starts(with: text) {
                        idxSetPriority.insert(index)
                    }
                    
                    if dataArray[index].searchText.starts(with: text) {
                        idxSetPriority.insert(index)
                    }
                }
            } else {
                for index in 0...(dataArray.count - 1) where dataArray[index].searchText.starts(with: text) {
                    idxSetPriority.insert(index)
                }
            }
        } else { // partial matching
            if partialMatching {
                for index in 0...(dataArray.count - 1) {
                    let convertedData = convertToPartial(word: dataArray[index].searchText)
                    
                    if convertedData.starts(with: convertToPartial(word: text)) {
                        idxSetPriority.insert(index)
                    }
                    
                    if dataArray[index].searchText.starts(with: text) {
                        idxSetPriority.insert(index)
                    }
                }
            } else {
                for index in 0...(dataArray.count - 1) where dataArray[index].searchText.starts(with: text) {
                    idxSetPriority.insert(index)
                }
            }
        }
        
        idxSetPriority.forEach {
            filteredData.append(dataArray[$0])
        }
        
        return filteredData
    }
    
    private func convertToInitial(word: String) -> String {
        var result = ""
        
        for char in word {
            let octal = char.unicodeScalars[char.unicodeScalars.startIndex].value
            if 44032...55203 ~= octal { // 유니코드가 한글값 일때만 분리작업
                let index = (octal - 0xac00) / 28 / 21
                result += hangle[0][Int(index)]
            }
        }
        
        return result
    }
    
    private func convertToPartial(word: String) -> String {
        return word.reduce("") { result, char in
            if case let code = Int(String(char).unicodeScalars.reduce(0) { $0 + $1.value }) - 44032, code > -1 && code < 11172 {
                let cho = code / 21 / 28
                let jung = code % (21 * 28) / 28
                let jong = code % 28
                return result + hangle[0][cho] + hangle[1][jung] + hangle[2][jong]
            }
            return result + String(char)
        }
    }
    
    private func isOnlyInitial(word: String) -> Bool {
        var onlyInitial = false
        for char in word {
            if 0 < hangle[0].filter({ $0.contains(char)}).count {
                onlyInitial = true
            } else {
                onlyInitial = false
                break
            }
        }
        return onlyInitial
    }
}
