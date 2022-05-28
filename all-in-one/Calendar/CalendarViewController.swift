//
//  CalendarViewController.swift
//  all-in-one
//
//  Created by 강민성_소스 on 2022/05/28.
//

import UIKit
import FSCalendar
import RealmSwift
import CalculateCalendarLogic

class CalendarViewController: UIViewController {
    
    var dataArr :Array<AddData> = []

    @IBOutlet weak var calendarView: FSCalendar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let data1 : AddData = AddData(
            date : "2022-05-27",
            title : "abc",
            sub : "def"
        )
        
        
        let data2 : AddData = AddData(
            date: "2022-05-26",
            title: "def",
            sub: "abc"
        )
        
        
        
        
        dataArr.append(data1)
        dataArr.append(data2)
        
        
        calendarView.allowsMultipleSelection = true
        calendarView.swipeToChooseGesture.isEnabled = true
        calendarView.scrollEnabled = true
        calendarView.scrollDirection = .horizontal
        calendarView.appearance.borderRadius = 0
        
        self.calendarText()
        self.calendarEvent()
        
    }
    
    
    
    
    func calendarText() {
        // 달력의 년월 글자 바꾸기
        calendarView.appearance.headerDateFormat = "YYYY년 M월"
        
        // 달력의 요일 글자 바꾸는 방법 1
        calendarView.locale = Locale(identifier: "ko_KR")
        
        // 달력의 요일 글자 바꾸는 방법 2
        calendarView.calendarWeekdayView.weekdayLabels[0].text = "일"
        calendarView.calendarWeekdayView.weekdayLabels[1].text = "월"
        calendarView.calendarWeekdayView.weekdayLabels[2].text = "화"
        calendarView.calendarWeekdayView.weekdayLabels[3].text = "수"
        calendarView.calendarWeekdayView.weekdayLabels[4].text = "목"
        calendarView.calendarWeekdayView.weekdayLabels[5].text = "금"
        calendarView.calendarWeekdayView.weekdayLabels[6].text = "토"
        
    }
    func calendarEvent() {
        calendarView.dataSource = self
        calendarView.delegate = self
    }
    
}
//서버 : db 에서 어제 오늘 데이터 비교 해서  calendar 에 추가 그냥 넣기
//fire base 해보기 디비 하나 스케줄러 : 1시간에 1번씩 긁어오ㅣ, 과거 현재 금액 비교 ->조건 맞춰서 토큰 브루 메세지 보내기
//알림 :

extension CalendarViewController: FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        guard let modalPresentView = self.storyboard?.instantiateViewController(identifier: "CalendarDitailViewController") as? CalendarDitailViewController else { return }
        //조건문으로 data 없을 때 처리 추가
        do {
            // 날짜를 원하는 형식으로 저장하기 위한 방법입니다.
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            modalPresentView.date = dateFormatter.string(from: date)
            //let realm = try Realm()
            let myDay = dateFormatter.string(from: date)
           // let saveData = realm.objects(AddData.self).filter("date == 'days'")
            modalPresentView.myText = dataArr[0].title//saveData[0].title
            let mydata : AddData = AddData(
                date : myDay,
                title : "추가",
                sub : "sub"
            )
            dataArr.append(mydata)
            self.present(modalPresentView, animated: true, completion: nil)
        }
        catch let error {
            print(error)
        }
    }

}
extension CalendarViewController: FSCalendarDataSource {
   /* func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        if self.dates.contains(where: date){
                return 1
            }
            return 0
        }*/
}


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


