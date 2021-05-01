//
//  DetailViewController.swift
//  MyMovieChart
//
//  Created by 이병훈 on 2020/09/06.
//  Copyright © 2020 이병훈. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController{
    
    @IBOutlet var wv: WKWebView!
    @IBOutlet var spinner: UIActivityIndicatorView!
    
    var mvo: MovieVO! //영화정보를 받을 변수
    
    override func viewDidLoad() {
        self.wv.navigationDelegate = self
        NSLog("linkurl = \(self.mvo.detail!), title = \(self.mvo.title!)")
        
        let navibar = self.navigationItem
        navibar.title = self.mvo.title //네비게이션아이템을 mvo의 제목으로 바꾼다.
        if let url = self.mvo.detail { //옵셔널 바인딩문 변수나 상수가 바인딩에 성공하면 true나 false를 반환한다.
            if let urlObj = URL(string: url) {
                let req = URLRequest(url:urlObj)
                self.wv.load(req)
            } else {
                let alert = UIAlertController(title:"오류", message: "잘못된 URL입니다.",preferredStyle: .alert) //알림창 생성
                
                let cancelAction = UIAlertAction(title:"확인", style: .cancel) {(_) in
                    _ = self.navigationController?.popViewController(animated: true)
                }
                alert.addAction(cancelAction)
                self.present(alert,animated: false,completion: nil)
            }
        } else {
            let alert = UIAlertController(title:"오류",message: "필수 파라미터가 누락되었습니다.",preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "확인", style: .cancel) { (_) in
                _=self.navigationController?.popViewController(animated: true)
            }
            alert.addAction(cancelAction)
            
            self.present(alert, animated: false, completion: nil)
        }
        /*옵셔널 바인딩을 안한 url문
        let url = URL(string: (self.mvo.detail)!)//URL인스턴스를 생성한다.
        let req = URLRequest(url:url!)//URL인스턴스를 인자값으로 하여 URLRequest인스턴스를 생성한다.
        
        self.wv.load(req)//웹킷 뷰 객체에 정의된 load() 메소드가 실행되면 비로소 웹뷰에 웹 페이지가 로드되면서 화면에 HTML 페이지가 출력
        */
 
    }
 
    
}
// MARK:- WKNavigationDelegate 프로토콜 구현 함수

extension DetailViewController: WKNavigationDelegate {
    /*
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        self.spinner.startAnimating() //인디케이터 뷰의 애니메이션을 실행한다.
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.spinner.stopAnimating() //인디케이터 뷰의 애니메이션을 정지한다.
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.spinner.stopAnimating() //오류가 발생했을때도 뷰의 애니메이션을 정지한다.
        
        let alert = UIAlertController(title: "오류", message: "상세페이지를 읽어오지 못했다.", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title:"확인", style: .cancel) {(_) in
            _ = self.navigationController?.popViewController(animated: true) //전 화면으로 돌아가기
        }
        alert.addAction(cancelAction)
        self.present(alert,animated: false, completion: nil)
    */
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.spinner.stopAnimating()
        self.alert("상세 페이지를 읽어오지 못했습니다.") {
            //버튼 클릭시 이전화면을 돌려보내기
            _ = self.navigationController?.popViewController(animated: true)
        }
    }
    /*아예 웹페이지를 못 읽어올때(오류),네트웤,URL 문제일경우 */
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        self.spinner.stopAnimating()
        
        self.alert("상세페이지를 읽어오지 못했다.") {
            //버튼 클릭시 이전화면을 돌려보내기
            _ = self.navigationController?.popViewController(animated: true)
        }
    }
    }
 
// MARK:- 심플한 경고창 함수 정의용 익스텐션
extension UIViewController {
    func alert(_ message: String, onClick: (()-> Void)? = nil) {
        let controller = UIAlertController(title: nil, message: message,preferredStyle: .alert)
        controller.addAction(UIAlertAction(title:"OK", style: .cancel) {(_) in
            onClick?()
        })
        DispatchQueue.main.sync {
            self.present(controller, animated: false)
        }
    }
}
