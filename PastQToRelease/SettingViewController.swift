//
//  SettingViewController.swift
//  PastQToRelease
//
//  Created by owner on 2016/08/06.
//  Copyright © 2016年 Yuki Yanagawa. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SettingViewController: UIViewController {
    @IBOutlet var Table:UITableView!
    var hairetu:[String] = ["アカウントを削除","利用規約"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.tintColor = Color().mainColor()  // バーアイテムカラー
        self.navigationController!.navigationBar.barTintColor = Color().koime()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
//    

    @IBAction func passchenge() {
            let alert = UIAlertController(title: "メール認証", message: "メール認証を行ってください", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
    }
    @IBAction func logout() {
        do {
            //do-try-catchの中で、FIRAuth.auth()?.signOut()を呼ぶだけで、ログアウトが完了
            try FIRAuth.auth()?.signOut()

            performSegue(withIdentifier: "End", sender: nil)

        }catch let error as NSError {
            
        }
        
    }
    
}
