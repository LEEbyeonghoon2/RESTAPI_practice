//
//  MovieCell.swift
//  MyMovieChart
//
//  Created by 이병훈 on 2020/08/21.
//  Copyright © 2020 이병훈. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
    
    @IBOutlet var title: UILabel!
    @IBOutlet var desc: UILabel!
    
    @IBOutlet var opendate: UILabel!
    @IBOutlet var rating: UILabel!
    
    @IBOutlet var tumbnail: UIImageView!
}
