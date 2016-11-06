//
//  RiyoukiyakuViewController.swift
//  PastQToRelease
//
//  Created by owner on 2016/08/06.
//  Copyright © 2016年 Yuki Yanagawa. All rights reserved.
//

import UIKit

class RiyoukiyakuViewController: UIViewController {
    @IBOutlet var honbun:UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        honbun.text="本アプリではみなさんの受験年や過去問の点数を管理していますが、個人の具体的な成績や志望校を漏洩することはいたしませんが、全ユーザーや一部ユーザーの過去問合計点や最高得点、平均点を開示することがありますのでご了承ください。\n第一条 本アプリに登録したユーザー情報（メールアドレス,受験年等）は運営に関する目的以外での使用はしません。\n第二条 このサービスで発生した紛争等に対し製作者は一切責任を負いません。\n第三条 このアプリで取得したデータや画像は全ユーザーが見ることが可能ですが、データや画像の無断転載は禁止します。データの提供を希望される方はご連絡ください\n第四条 このアプリ内の支払いはApple社の定めた範囲（iTunesStoreなど）に限定します。クレジットカードや銀行口座での引き落とし等は受け付けません。\nこの利用規約（プライバシーポリシー）は予告なしに改訂することがあります。\n制定 平成28年9月1日"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
