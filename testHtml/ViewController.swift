//
//  ViewController.swift
//  testHtml
//
//  Created by Can Lee on 2020/4/4.
//  Copyright © 2020 Can Lee. All rights reserved.
//

import UIKit

let testHTML = """
<p>
    <span style="font-family:'Microsoft YaHei';font-size:14px;">1、完成银行转账</span><span
        style="font-family:'Microsoft YaHei';font-size:14px;">15</span><span
        style="font-family:'Microsoft YaHei';font-size:14px;">分钟以上充值仍未到账的原因及解决办法：</span><span><br />
        <br />
    </span><span style="font-family:'Microsoft YaHei';font-size:14px;">（</span><span
        style="font-family:'Microsoft YaHei';font-size:14px;">1</span><span
        style="font-family:'Microsoft YaHei';font-size:14px;">）汇款未使用平台提供的最新银行信息</span><span><br />
    </span><span style="font-family:'Microsoft YaHei';font-size:14px;">（</span><span
        style="font-family:'Microsoft YaHei';font-size:14px;">2</span><span
        style="font-family:'Microsoft YaHei';font-size:14px;">）汇款时候附言填写错误或者未填写</span><span><br />
    </span><span style="font-family:'Microsoft YaHei';font-size:14px;">（</span><span
        style="font-family:'Microsoft YaHei';font-size:14px;">3</span><span
        style="font-family:'Microsoft YaHei';font-size:14px;">）平台填写金额与实际汇款金额不一致</span><span><br />
    </span><span style="font-family:'Microsoft YaHei';font-size:14px;">（</span><span
        style="font-family:'Microsoft YaHei';font-size:14px;">4</span><span
        style="font-family:'Microsoft YaHei';font-size:14px;">）平台填写充值信息之后，超过</span><span
        style="font-family:'Microsoft YaHei';font-size:14px;">30</span><span
        style="font-family:'Microsoft YaHei';font-size:14px;">分钟才进行汇款</span><span><br />
        <br />
    </span><span style="font-family:'Microsoft YaHei';font-size:14px;">以上任何一点都会引起您的充值未到账，请及时联系客服，<span
            style="color:#E53333;">并提供银行回单截图等相关证明</span>。</span><span><br />
        <br />
    </span><span
        style="font-family:'Microsoft YaHei';font-size:14px;">注：需提供的证明——平台账户名、银行转账汇款回执单截图（截图需包含汇款人姓名、汇款银行卡号以及金额和汇款的具体时间）</span><span><br />
        <br />
        <span style="font-family:'Microsoft YaHei';font-size:14px;"> 2</span></span><span
        style="font-family:'Microsoft YaHei';font-size:14px;">、未能成功提现的原因及解决办法：</span><span><br />
        <br />
    </span><span style="font-family:'Microsoft YaHei';font-size:14px;">（</span><span
        style="font-family:'Microsoft YaHei';font-size:14px;">1</span><span
        style="font-family:'Microsoft YaHei';font-size:14px;">）会员账户的存款额未满足</span><span
        style="font-family:'Microsoft YaHei';font-size:14px;">30%</span><span
        style="font-family:'Microsoft YaHei';font-size:14px;">投注要求</span><span><br />
    </span><span style="font-family:'Microsoft YaHei';font-size:14px;">（</span><span
        style="font-family:'Microsoft YaHei';font-size:14px;">2</span><span
        style="font-family:'Microsoft YaHei';font-size:14px;">）提现绑定的银行卡信息有误</span><span><br />
    </span><span style="font-family:'Microsoft YaHei';font-size:14px;">（</span><span
        style="font-family:'Microsoft YaHei';font-size:14px;">3</span><span
        style="font-family:'Microsoft YaHei';font-size:14px;">）银行卡被银行冻结或过期</span><span><br />
        <br />
        <span style="font-family:'Microsoft YaHei';font-size:14px;"> </span></span><span
        style="font-family:'Microsoft YaHei';font-size:14px;">由（</span><span
        style="font-family:'Microsoft YaHei';font-size:14px;">1</span><span
        style="font-family:'Microsoft YaHei';font-size:14px;">）引起的提现失败，请玩家自行遵守平台提现规定后再进行提现操作；</span><span><br />
        <span style="font-family:'Microsoft YaHei';font-size:14px;"> </span></span><span
        style="font-family:'Microsoft YaHei';font-size:14px;">由（</span><span
        style="font-family:'Microsoft YaHei';font-size:14px;">2</span><span
        style="font-family:'Microsoft YaHei';font-size:14px;">）、（</span><span
        style="font-family:'Microsoft YaHei';font-size:14px;">3</span><span
        style="font-family:'Microsoft YaHei';font-size:14px;">）引起的提现失败，请玩家选择匹配正确的银行卡再进行提现操作。</span><span><br />
        <br />
        <span style="font-family:'Microsoft YaHei';font-size:14px;"> 3</span></span><span
        style="font-family:'Microsoft YaHei';font-size:14px;">、如何修改已经锁定的取款人信息：</span><span><br />
        <br />
    </span><span
        style="font-family:'Microsoft YaHei';font-size:14px;">联系在线客服并提供正确的平台账号、银行卡号、取款人姓名等信息，经客服核实无误后完成修改。</span>
</p>
"""

class ViewController: UIViewController {
    static let cellId = "cellId"
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.frame, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MyCell.self, forCellReuseIdentifier: ViewController.cellId)
        tableView.tableFooterView = UIView()
        return tableView
    }()
    var dataArr: [MyModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        dataArr = [MyModel(), MyModel(), MyModel()]
        
    }
    func createModels() -> [MyModel] {
        let m1 = MyModel(content: "1231231", isShow: false)
        let m2 = MyModel(content: "今晚吃pizza", isShow: false)
        let m3 = MyModel(content: "时时彩123时时彩123时时彩123时时彩123时时彩123时时彩123时时彩123时时彩123时时彩123时时彩123时时彩123时时彩123时时彩123时时彩123时时彩123时时彩123时时彩123时时彩123时时彩123时时彩123时时彩123时时彩123时时彩123时时彩123时时彩123时时彩123时时彩123时时彩123时时彩123时时彩123时时彩123时时彩123时时彩123时时彩123时时彩123时时彩123时时彩123时时彩123时时彩123时时彩123时时彩123时时彩123时时彩123时时彩123时时彩123时时彩123时时彩123时时彩123", isShow: false)
        return [m1, m2, m3]
    }


}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataArr.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let model = dataArr[section]
        if model.isShow {
            return 1
        } else {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let btn = UIButton(type: .custom)
        btn.setTitle("\(section)", for: .normal)
        btn.addTarget(self, action: #selector(clickBtn(_:)), for: .touchUpInside)
        btn.tag = section
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.backgroundColor = UIColor.white
        return btn
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ViewController.cellId, for: indexPath) as! MyCell
//        cell.contentView.backgroundColor = .red
        let model = dataArr[indexPath.row]
        cell.model = model
        cell.clickBlock = {[weak self] (index) in
            self?.request1(index: index, section: indexPath.section)
        }
        cell.webviewLoadedBlock = {[weak self] in
            // 这个方法不会调数据源，只调delegate, 会更新cell里面内容的高度，比如子控件webview
            //并且带动画
            tableView.beginUpdates()
            tableView.endUpdates()
            
            // 用这个方法，webview的frame高度为0
//            tableView.reloadSections(IndexSet(integer: indexPath.section), with: .none)
            // 这个方法就可以，但没有动画
//            tableView.reloadData()
        }
        return cell

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = dataArr[indexPath.section]
        if let cellHeight = model.cellHeight {
            return cellHeight
        } else {
            return 50 + 30
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    @objc func clickBtn(_ sender: UIButton) {
        let model = dataArr[sender.tag]
        model.isShow = !model.isShow
        tableView.reloadSections(IndexSet(integer: sender.tag), with: .none)
        // 发请求数据
        request(index: sender.tag)
    }
    // 首次加载
    func request(index: Int)  {
        let model = createModels()[index]
        dataArr[index].content = model.content
        dataArr[index].state = .loading
        dataArr[index].cellHeight = 80

        tableView.reloadSections(IndexSet(integer: index), with: .none)

    }
    // 切换按钮加载数据
    func request1(index: Int, section: Int) {
        dataArr[section].content = createModels()[index].content
        dataArr[section].state = .loading
        tableView.reloadSections(IndexSet(integer: section), with: .none)
    }
}

enum WebviewState {
    case loading, loaded
}

class MyModel {
    var content: String?
    var isShow: Bool = false
    var cellHeight: CGFloat?
    var state: WebviewState = .loading
    convenience init(content: String, isShow: Bool) {
        self.init()
        self.content = content
        self.isShow = isShow
    }
}
