//
//  AuthUtil.swift
//  Shared
//
//  Created by hhhello0507 on 9/20/24.
//

import Foundation

public enum FormatUtil {
    public static func formatPhone(_ phone: String) -> String? {
        switch phone.count {
        case 4:
            if phone[3] == "-" { // 010-
                phone[0..<3]
            } else { // 0108
                "\(phone[0..<3])-\(phone[3])"
            }
        case 9:
            if phone[8] == "-" { // 010-1234-
                phone[0..<8]
            } else { // 010-12345
                "\(phone[0..<8])-\(phone[8])"
            }
        case 14...: // 010-1234-56789
            phone[0..<13]
        default:
            nil
        }
    }
    
    public static func formatMemberInfo(_ memberInfo: String) -> String? {
        switch memberInfo.count {
        case 1: // 학년을 입력한 경우: "" (0글자)
            "\(memberInfo[0])학년"
        case 2: // 학년을 삭제한 경우: "1학년"
            ""
        case 4: // 반을 입력한 경우: "1학년2"
            "\(memberInfo[0])학년 \(memberInfo[3])반"
        case 5: // 반을 삭제한 경우: "1학년 2
            "\(memberInfo[0])학년"
        case 7: // 번호를 입력한 경우: "1학년 2반3"
            "\(memberInfo[0])학년 \(memberInfo[4])반 \(memberInfo[6])번"
        case 8: // 번호를 삭제한 경우: "1학년 2반 3"
            "\(memberInfo[0])학년 \(memberInfo[4])반"
        case 9 where memberInfo[8] != "번": // 번호가 두 글자일 때 번호를 삭제한 경우: "1학년 2반 34"
            "\(memberInfo[0])학년 \(memberInfo[4])반 \(memberInfo[7])번"
        case 10 where memberInfo[9] != "번": // 번호를 한 글자 더 추가한 경우: "1학년 2반 3번4"
            "\(memberInfo[0])학년 \(memberInfo[4])반 \(memberInfo[7])\(memberInfo[9])번"
        case 11...: // "1학년 2반 34번1"
            memberInfo[0..<10]
        default:
            nil
        }
    }
}
