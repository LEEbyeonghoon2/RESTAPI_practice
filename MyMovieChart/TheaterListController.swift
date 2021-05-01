//
//  TheaterListController.swift
//  MyMovieChart
//
//  Created by 이병훈 on 2020/09/10.
//  Copyright © 2020 이병훈. All rights reserved.
//

import UIKit

class TheaterListController : UITableViewController {
    
    var list = [NSDictionary]() //NSDictionary는 키와 값으로 구성된것으로 ["":""]식으로 되어있다.
    
    var startPoint = 0
    
    override func viewDidLoad() {
        self.callTheaterAPI()
    }
    
    func callTheaterAPI() {
        let requestURI = "http://swiftapi.rubypaper.co.kr:2029/theater/list"
        let sList = 100 //불러올 데이터 갯수 변수
        let type = "json"
        
        let urlOBJ = URL(string: "\(requestURI)?s_page=\(self.startPoint)&s_list=\(sList)&type=\(type)")//url을 설정하는것
        
        do {
            //NSString객체를 이용하여 api를 호출하고 인코딩된 문자열을 받아온다.
            let stringdata = try NSString(contentsOf: urlOBJ!, encoding: 0x80_000422)
            //문자열로 받은 데이터를 UTF-8로 인코딩한 data로 변환한다.
            let encdata = stringdata.data(using: String.Encoding.utf8.rawValue)
            do {
                //data 객체를 파싱하여 NSArray객체로 변환한다.
                let apiArray = try JSONSerialization.jsonObject(with: encdata!, options: []) as? NSArray
                
                
                for obj in apiArray! {
                    self.list.append(obj as! NSDictionary)
                }
            } catch {
                let alert = UIAlertController(title: "실패", message: "데이터 분석이 실패", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title:"확인", style: .cancel))
                
                self.present(alert, animated: false)
            }
            self.startPoint += sList //읽어와야 할 다음 페이지의 데이터 시작위치 지정
        } catch {
            let alert = UIAlertController(title: "실패", message: "데이터를 불러오는데 실패", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "확인", style: .cancel))
            self.present(alert,animated: false)
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count //테이블 뷰의 크기
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // self.list 배열에서 행에맞는 데이터를 꺼낸다.
        let obj = self.list[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tCell") as! TheaterCell
        
        cell.name?.text = obj["상영관명"] as? String //상영관명인 인덱스를 찾아string형으로 변환해서 text에 넣는다
        cell.tel?.text = obj["연락처"] as? String //연락처인 인덱스를 찾아 string형으로 변환해서 text에 넣는다.
        cell.addr?.text = obj["소재지도로명주소"] as? String //소재지 도로명주소인 인덱스를 찾아서 string형으로 변환하고 text에 넣는다.
        
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          if(segue.identifier == "segue_map") { //실행된 세그웨이의 식별자가 segue_map이라면
              //선택된 셀의 행의 정보를 path 상수에 넣는다.
              let path = self.tableView.indexPath(for: sender as! UITableViewCell)
              //선택된 셀의 데이터
            let data = self.list[path!.row]
            //세그웨이가 이동할 목적지 뷰 컨트롤러 객체를 구하고 param변수에 데이터를 연결
            (segue.destination as? TheaterViewController)?.param = data
          }
      }
}
