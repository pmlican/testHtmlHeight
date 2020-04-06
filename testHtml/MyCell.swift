//
//  MyCell.swift
//  testHtml
//
//  Created by Can Lee on 2020/4/4.
//  Copyright © 2020 Can Lee. All rights reserved.
//

import UIKit
import WebKit

class MyCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style:style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    var clickBlock: ((_ index: Int)->())?
    var webviewLoadedBlock: (()->())?
    var model: MyModel? {
        didSet {
            if let state = model?.state,let html = model?.content {
                if state == .loaded {
                    indicator.stopAnimating()
                } else {
                    indicator.startAnimating()
                    bgWebView.loadHTMLString(html.resizeHtml, baseURL: nil)
                    webView.loadHTMLString(html.resizeHtml, baseURL: nil)
                }
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // 这个用来展示内容
    lazy var webView: WKWebView = {
       let webview = WKWebView()
        webview.navigationDelegate = self
        return webview
    }()
    // 要用一个bgview来获取高度，不然在切换loadHTMLString内容时，webview加载完成后获取的高度不变
    lazy var bgWebView: WKWebView = {
       let webview = WKWebView()
        webview.navigationDelegate = self
        return webview
    }()
    lazy var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .gray)
        return indicator
    }()

    var oberseve: NSKeyValueObservation?
    
    func setupUI() {
        var btnx: CGFloat = 0
        let btnW: CGFloat = 80
        let btnH: CGFloat = 50
        for i in 0..<3 {
            let btn = UIButton(type: .custom)
            btn.setTitleColor(.black, for: .normal)
            btn.setTitle("按钮\(i)", for: .normal)
            btn.setTitleColor(.black, for: .normal)
            
//            let btnSize = btn.sizeThatFits(.zero)
            btn.backgroundColor = UIColor.brown
            btnx = (btnW + 5) * CGFloat(i) + 5
            btn.frame = CGRect(x: btnx, y: 0, width: btnW, height: btnH)
            btn.tag = i
            btn.addTarget(self, action: #selector(clickBtn(_:)), for: .touchUpInside)
            contentView.addSubview(btn)
        }
        contentView.addSubview(bgWebView)
        contentView.addSubview(webView)
        contentView.addSubview(indicator)
        indicator.frame = CGRect(x: 0, y: btnH, width: UIScreen.main.bounds.width, height: 30)
    
        bgWebView.frame = CGRect(x: 0, y: btnH, width: UIScreen.main.bounds.width, height: 0)
        webView.frame = CGRect(x: 0, y: btnH, width: UIScreen.main.bounds.width, height: 0)

        oberseve = webView.observe(\WKWebView.scrollView.contentSize, options:[.new], changeHandler: { (obj, change) in
//            if let height = change.newValue?.height {
//                print("chang--\(height)")
//            }
//            obj.evaluateJavaScript("document.body.scrollHeight") { (value, error) in
//                print("document.body.scrollHeight ==》",value)
//            }
//            obj.evaluateJavaScript("document.body.offsetHeight") { (value, error) in
//                print("document.body.offsetHeight ==》",value)
//            }

        })
    }
    deinit {
        oberseve = nil
    }
    @objc func clickBtn(_ sender: UIButton) {
        clickBlock?(sender.tag)
    }
}
extension String {
    var resizeHtml: String {
        let code = """
        <meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0'>
        <meta name='apple-mobile-web-app-capable' content='yes'>
        <meta name='apple-mobile-web-app-status-bar-style' content='black'>
        <meta name='format-detection' content='telephone=no'>
        <style type='text/css'>
            img {
                width: 100%
            }

            p {
                font-size: 14px
            }
            body {
                font-size: 14px;
            }
            span {
                font-size: 14px;
            }
        </style>
        """
        return "\(self)\(code)"
//        return self
        
    }
}

extension MyCell: WKNavigationDelegate{
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        print("webview加载完成\(webView.scrollView.contentSize.height)")
//        webView.evaluateJavaScript("document.body.scrollHeight") {[weak self] (value, error) in
//            print("webview加载完成 - document.body.scrollHeight ==》",value)
//
//        }
//        webView.evaluateJavaScript("document.body.offsetHeight") {[weak self] (value, error) in
//            print("webview加载完成 - document.body.offsetHeight ==》",value)
//            if let height = value as? CGFloat {
//                self?.model?.cellHeight = (height + 50.0)
//            }
//            self?.webviewLoadedBlock?()
//        }
//        webView.evaluateJavaScript("document.readyState", completionHandler: { result, error in
//
//            if result == nil || error != nil {
//                return
//            }
//
//            webView.evaluateJavaScript("document.body.scrollHeight", completionHandler: {[weak self] value, error in
//                print("webview加载完成 - document.body.scrollHeight ==》",value)
//                if let height = value as? CGFloat {
//                    self?.model?.cellHeight = (height + 50.0)
//                    self?.webView.frame.size.height = height
//                }
//                self?.webviewLoadedBlock?()
//            })
//        })
        if webView == bgWebView {
            webView.evaluateJavaScript("document.body.scrollHeight", completionHandler: {[weak self] value, error in
                print("webview加载完成 - document.body.scrollHeight ==》",value)
                if let height = value as? CGFloat {
                    self?.model?.cellHeight = (height + 50.0)
                    // 因为改变了webview高度后，但后续内容改变时，获取的高度也不变
                    self?.webView.frame.size.height = height
                }
                self?.model?.state = .loaded
                self?.webviewLoadedBlock?()
                self?.indicator.stopAnimating()
            })
        }
        
    }
}
