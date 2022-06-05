//
//  tempData.swift
//  all-in-one
//
//  Created by 구본규 on 2022/05/26.
//

import Foundation

let date = Date()
let todayClock = Calendar.current.dateComponents([.hour, .minute], from :date)

struct EconomyIndex{ // 모델
    var name: String // 지수 이름
    var point: Double // 포인트
    var range: Double // 변동폭
    let time = todayClock
}

var kospi: EconomyIndex = EconomyIndex(name: "코스피", point: 2686.05, range: -0.77)
var kosdaq: EconomyIndex = EconomyIndex(name: "코스닥", point: 918.40, range: -0.98)
var nasdaq: EconomyIndex = EconomyIndex(name: "나스닥", point: 13758.46, range: -0.78)
var dowjones: EconomyIndex = EconomyIndex(name: "다우존스", point: 34579.42, range: -0.51)
var sp500: EconomyIndex = EconomyIndex(name: "S&P500", point: 4455.4, range: 0.17)

var alarmList = [kospi, kosdaq, nasdaq, dowjones, sp500]

