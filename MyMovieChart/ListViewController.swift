//
//  ListViewController.swift
//  MyMovieChart
//
//  Created by 이병훈 on 2020/08/19.
//  Copyright © 2020 이병훈. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {
    /* api로인해 제거가능
    /*가독성을 위한 리팩토링*/
    var dataset = [
        ("다크나이트","영웅물에 철학에 음악까지 더해져 예술이 되다.","2008-09-04",8.95,"darknight.jpg"),
        ("호우시절","때를 알고 내리는 좋은 비", "2009-10-08",7.31,"rain.jpg"),
        ("말할수 없는 비밀","여기서 너까지 다섯걸음","2015-05-07",9.19,"secret.jpg")
    ]//데이터 셋 배열을 넣는다.
 */
    //테이블 뷰를 생성할 리스트 데이터
    @IBOutlet var moreBtn: UIButton!
    var page = 1
    @IBAction func more(_ sender: Any) {
        self.page += 1 //현재 페이지값에 1을 추가해준다.
        self.callMovieAPI()
        self.tableView.reloadData()
        /*
        
        let url = "http://swiftapi.rubypaper.co.kr:2029/hoppin/movies?version=1&page=1&count=10&genreId=&order=releasedateasc"
        
        let apiURI: URL! = URL(string: url)
        
        let apidata = try! Data(contentsOf: apiURI)
        
        let log = NSString(data: apidata, encoding: String.Encoding.utf8.rawValue) ?? "데이터가 없습니다."
        
        NSLog("API Result = \( log )")
        
        do {
            let apiDictionary = try JSONSerialization.jsonObject(with: apidata, options: []) as! NSDictionary
            
            let hoppin = apiDictionary["hoppin"] as! NSDictionary
            let movies = hoppin["movies"] as! NSDictionary
            let movie = movies["movie"] as! NSArray
            
            for row in movie {
                let r = row as! NSDictionary
                
                let mvo  = MovieVO()
                
                mvo.title = r["title"] as? String
                mvo.description = r["genreNames"] as? String
                mvo.thumbnail = r["thumbnailImage"] as? String
                mvo.detail = r["linkUrl"] as? String
                mvo.rating = ((r["ratingAverage"] as! NSString).doubleValue)
                
                self.list.append(mvo)
                
                self.tableView.reloadData()
            }
 
        } catch { }
*/
 }
    func callMovieAPI() { //API관련 생성 메소드
        let url = "http://swiftapi.rubypaper.co.kr:2029/hoppin/movies?version=1&page=1&count=30&genreId=&order=releasedateasc"
               
               let apiURI: URL! = URL(string: url)
               
               let apidata = try! Data(contentsOf: apiURI)
               
               let log = NSString(data: apidata, encoding: String.Encoding.utf8.rawValue) ?? "데이터가 없습니다."
               
               NSLog("API Result = \( log )")
               
               do {
                   let apiDictionary = try JSONSerialization.jsonObject(with: apidata, options: []) as! NSDictionary
                   
                   let hoppin = apiDictionary["hoppin"] as! NSDictionary
                   let movies = hoppin["movies"] as! NSDictionary
                   let movie = movies["movie"] as! NSArray
                   
                   for row in movie {
                       let r = row as! NSDictionary
                       
                       let mvo  = MovieVO()
                       
                       mvo.title = r["title"] as? String
                       mvo.description = r["genreNames"] as? String
                       mvo.thumbnail = r["thumbnailImage"] as? String
                       mvo.detail = r["linkUrl"] as? String
                       mvo.rating = ((r["ratingAverage"] as! NSString).doubleValue)
                    //웹상에 있는 이미지를 읽어와서 UIImage객체로 생성한다.
                    let url: URL! = URL(string: mvo.thumbnail!)
                    let imageData = try! Data(contentsOf: url)
                    mvo.thumbnaiImage = UIImage(data:imageData)
                       
                       self.list.append(mvo)

                    
                    //totalCount가 데이터 크기보다 클경우 버튼을 숨긴다.
                   }
                //전체 데이터의 갯수를 얻는다.
                let totalCount = (hoppin["totalCount"] as? NSString)!.integerValue
                
                if (self.list.count >= totalCount) {
                    self.moreBtn.isHidden = true
                }
        
               } catch {
                NSLog("Parse Error!")
        }
    }
 
    lazy var list: [MovieVO] = {//MovieVO클래스형의 배열 생성
        var datalist = [MovieVO]() //MovieVo타입형 배열 생성
        /*api로 인해 제거가능
        for(title,desc,opendate,rating,tumbnail) in self.dataset {
            let mvo = MovieVO()
            mvo.title = title
            mvo.description = desc
            mvo.opendate = opendate
            mvo.rating = rating
            mvo.thumbnail = tumbnail
            
            datalist.append(mvo)
        }
 */
        return datalist
        
    }()
    /*행의 개수를 반환하여 생성하는 메소드*/
    override func tableView(_ tableView:UITableView,numberOfRowsInSection section: Int) ->Int {
        return self.list.count //리트스 배열의 행의 갯수의 반환 값만큼 생성 .count는 배열타입 객체의 길이를 가져오는 속성
    }
    /*구성한 행의 화면에 표현해야 할 내용을 구성,프로토타입 쉘의 기본으로 제공하는 템플릿*/
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        //indexPath.row속성을 이용하여 행번호를 알아낸다,self.list를 통하여 해당 배열을 지정한다.
        let row = self.list[indexPath.row]
        //테이블 셀 객체를 직접 생성하는 대신 큐로부터 가져온다,.dequeueResuableCell메소드는 인자값으로 입력받은 아이디를 이용하여 스토리보드에 정의된 프로토타입 셀을 찾고 이를 인스턴스로 생성하여 우리에게 제공,재사용 큐라는 객체,없을수도 있기 때문에 옵셔널 타입으로 반환
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell")!
        cell.textLabel?.text = row.title
        
        cell.detailTextLabel?.text = row.description //detailTextLabel은 서브타이틀에 데이터 연결 한다.
        
        return cell
    }
    */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //주어진 행에 맞는 데이터 소스를 가져온다
        let row = self.list[indexPath.row]
        //스토리보드에서 봤듯이 우리는 프로토타입 쉘을 MovieCell클래스로 연결해 주었다 따라서 이 클래스에 정의된 속성을 사용하려면 캐스팅을 해주어야한다.
        NSLog("제목: \(row.title!),호출된 행번호: \(indexPath.row)")
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell") as! MovieCell
        /*
        //각 영화제목에 표시될 레이블 값을 받아온다, 옵셔널 타입,UIView 타입을 리턴 받는다.
        let title = cell.viewWithTag(101) as? UILabel
        let desc = cell.viewWithTag(102) as? UILabel
        let opendate = cell.viewWithTag(103) as? UILabel
        let rating = cell.viewWithTag(104) as? UILabel
        */
        cell.title?.text = row.title
        cell.desc?.text = row.description
        cell.opendate?.text = row.opendate
        cell.rating?.text = "\(row.rating!)"
        /*
        cell.tumbnail.image = UIImage(named:row.thumbnail!) //앱의 로컬 경로에 있는 이미지를 읽어오는 방식이기 때문에 프로젝트 내부에 이미지 파일이 있는경우에만 사용가능
         */
        /* callMovieAPI에 넣어서 재사용 매커니즘을 사용
        let url: URL! = URL(string: row.thumbnail!)
        //섬네일 경로를 인자값으로 하는 URL객체
        
        let imageData = try! Data(contentsOf: url)
        //섬네일 경로를 통해 읽어온 객체를 Data객체에 저장
        
        cell.tumbnail.image = UIImage(data: imageData)
        //UIImage객체를 생성하여 아울렛 변수의 image속성에 넣는다.
 */
        //비동기 방식으로 섬네일 이미지를 읽어온다
        DispatchQueue.main.async {
            cell.tumbnail.image = self.getThumbnailImage(indexPath.row)
            NSLog("비동기 방식으로 실행중인 부분")
        }
        /*
        cell.tumbnail.image = row.thumbnaiImage //이미지 객체를 대입
 */
        return cell
    }
    /*그행을 클릭했을때 활용되는 메소드,내용*/
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("선택된 행은 \(indexPath.row)번째 입니다.")
    }
    override func viewDidLoad() {
        self.callMovieAPI()
        /*
        //1호핀 API 호출을 위한 URI 생성
        let url = "http://swiftapi.rubypaper.co.kr:2029/hoppin/movies?version=1&page=1&count=10&genreId=&order=releasedateasc"
        
        let apiURI: URL! = URL(string: url)
        //REST API를 호출
        let apidata = try! Data(contentsOf: apiURI)
        
        //전송결과 로그로 출력 
        let log = NSString(data: apidata, encoding: String.Encoding.utf8.rawValue) ?? ""
        NSLog("API Result=\( log )")
        
        do {
            let apiDictionary = try JSONSerialization.jsonObject(with: apidata, options: []) as! NSDictionary
            
            let hoppin = apiDictionary["hoppin"] as! NSDictionary
            let movies = hoppin["movies"] as! NSDictionary
            let movie = movies["movie"] as! NSArray
            
            for row in movie {
                let r = row as! NSDictionary
                
                let mvo = MovieVO()
                
                mvo.title = r["title"] as? String
                mvo.description = r["genreNames"] as? String
                mvo.thumbnail = r["thumbnailImage"] as? String
                mvo.detail = r["linkUrl"] as? String
                mvo.rating = ((r["ratingAverage"] as! NSString).doubleValue)
                
                self.list.append(mvo)
            }
        } catch { }
 */
    }
    /*프로그래밍 코드
    var list = [MovieVO]() //테이블 뷰를 구성할 배열 인스턴스 생성,MovieVo타입으로 배열 생성
    
    override func viewDidLoad() { //뷰컨트롤러가 초기화 되면서 뷰가 메모리에 로딩될때 호출하는 메소드
        var mvo = MovieVO()
        mvo.title = "다크나이트"
        mvo.description = "영웅물에 철학에 음악까지 더해져 예술이 되다."
        mvo.opendate = "2008-09-04"
        mvo.rating = 8.95
        
        self.list.append(mvo) //테이블 뷰를 구성하는 배열인스턴스에 추가
        
        mvo = MovieVO()//앞의 레퍼런스를 끊고 새 인스턴스의 레퍼런스를 넣어주면 배열에 영향을 끼치지않는다.
        mvo.title = "호우시절"
        mvo.description = "떄를 알고 내리는 좋은비"
        mvo.opendate = "2009-10-08"
        mvo.rating = 7.31
        
        self.list.append(mvo)//2번째 배열에 추가
        
        mvo = MovieVO()
        mvo.title = "말할 수 없는 비밀"
        mvo.description = "여기서 너까지 다섯걸음"
        mvo.opendate = "2015-05-07"
        mvo.rating = 9.19
        
        self.list.append(mvo) //3번째 배열에 추가
    }
 */
    func getThumbnailImage(_ index: Int) -> UIImage {
        let mvo = self.list[index] // 해당 인덱스의 배열 데이터를 읽어온다.
        
        //메모이제이션: 저장된 이미지가 있으면 그것을 반환하고, 없을경우 내려받아 저장한 후 반환한다.
        if let savedImage = mvo.thumbnaiImage {
            return savedImage
        } else {
            let url: URL! = URL(string: mvo.thumbnail!)
            let imageData = try! Data(contentsOf: url)
            mvo.thumbnaiImage = UIImage(data: imageData) //UIImage를 MovieVO객제에 우선 저장
            
            return mvo.thumbnaiImage! //위에서 저장한 이미지를 반환 한다.
        }
    }
}

//MARK: - 화면전환시 값을 넘겨지기위한 세그웨이 관련처리
extension ListViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue_detail" {
            let cell = sender as! MovieCell //sender인자를 MovieCell인자로 캐스팅 한다.
            
            let path = self.tableView.indexPath(for: cell)//사용자가 클릭한 행을 찾는것
            
            let movieinfo = self.list[path!.row] //해당 클릭한 행의 배열값을 movieinfo에 넣는다.
            
            //행정보를 통해 선택된 영화 데이터를 찾은 다음, 목적지 뷰컨트롤러의 mvo 변수에 대입한다.
            let detailVC = segue.destination as? DetailViewController//목적지에 해당하는 뷰컨트롤러 객체인 DetailController을 참조한다.
            detailVC?.mvo = movieinfo
        }
    }
}
