//
//  TheaterCell.swift
//  MyMovieChart
//
//  Created by 이병훈 on 2020/09/10.
//  Copyright © 2020 이병훈. All rights reserved.
//

import UIKit

class TheaterCell : UITableViewCell { //프로토타입 셀을 커스마이징할 클래스를 생성
    //상영관명
    @IBOutlet var name: UILabel!
    //주소
    @IBOutlet var addr: UILabel!
    //전화번호
    @IBOutlet var tel: UILabel!
    
}
