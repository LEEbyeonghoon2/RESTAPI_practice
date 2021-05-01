//
//  MovieVO.swift
//  MyMovieChart
//
//  Created by 이병훈 on 2020/08/20.
//  Copyright © 2020 이병훈. All rights reserved.
//

import Foundation
import UIKit

class MovieVO { //영화정보를 담기위한 객체생성
    var thumbnail: String? //영화 섬네일 이미지 주소
    var title: String? // 영화제목
    var description: String? //영화 섦명
    var detail: String?// 상세정보
    var opendate: String?// 개봉일
    var rating: Double?// 평점
    
    //UIImage를 사용하기위해 UIkit를 import한다.
    var thumbnaiImage: UIImage?
}
