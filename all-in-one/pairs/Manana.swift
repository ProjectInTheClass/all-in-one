//
//  USDKRW.swift
//  all-in-one
//
//  Created by 박현준 on 2022/05/26.
//

import Foundation

// MARK: - Manana
struct MananaElement: Codable {
    let date, name: String
    let rate: Double
    let timestamp: String
}

typealias Manana = [MananaElement]
