//
//  MySOCViewController.swift
//  PastQToRelease
//
//  Created by owner on 2016/08/15.
//  Copyright © 2016年 Yuki Yanagawa. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import DZNEmptyDataSet


class MySOCViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate {
    @IBOutlet var Table:UITableView!
    var hairetu:[String] = []
    var id: String!
    let dateFormatter = DateFormatter()
    let now = Date()
    var snap: FIRDataSnapshot!
    var point: String!
    let ref = FIRDatabase.database().reference()
    var Array:[FIRDataSnapshot] = []
    let userDefaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.tintColor = Color().mainColor()
        self.navigationController!.navigationBar.barTintColor = Color().koime()
        Table.emptyDataSetSource = self
        Table.emptyDataSetDelegate = self
        
        dateFormatter.dateFormat = "yyyyMMddmmss"
        id = "\(dateFormatter.string(from: now))"
        
        self.read()
        Table.delegate = self
        Table.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return hairetu.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Table.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel!.text = hairetu[(indexPath as NSIndexPath).row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        point = hairetu[(indexPath as NSIndexPath).row]
        performSegue(withIdentifier: "GoNext", sender: nil)
        
    }
    func read()  {
        //FIRDataEventTypeを.Valueにすることにより、なにかしらの変化があった時に、実行
        //今回は、childでユーザーIDを指定することで、ユーザーが投稿したデータの一つ上のchildまで指定することになる
        
        ref.child("SoCdata").queryOrdered(byChild: "user").queryEqual(toValue: (FIRAuth.auth()?.currentUser?.uid)!).observe(.value, with: {(snapShots) in
            if snapShots.children.allObjects is [FIRDataSnapshot] {
                print("snapShots.children...\(snapShots.childrenCount)")
                //いくつのデータがあるかプリント
                
                print("snapShot...\(snapShots)")
                //読み込んだデータをプリント
                
                self.snap = snapShots
            }
            self.reload(self.snap)
        })
    }
    func reload(_ snap: FIRDataSnapshot) {
        //FIRDataSnapshotが存在するか確認
        if snap.exists() {
            Array.removeAll()
            
            //1つになっているFIRDataSnapshotを分割し、配列に入れる
            for item in snap.children {
                Array.append(item as! FIRDataSnapshot)
                
            }
        }
        self.ashita()
    }
    
    
    func ashita(){
        
        //FIRDataSnapShotは辞書型なので取り出すこと
        for value in Array {
            
            let item = value.value as! Dictionary<String, AnyObject>
            print(item)
            let sa = item["school"] as! String
            let index = hairetu.index(of: sa)
            if index == nil{
                hairetu.append(sa)
            }
        }
        
        userDefaults.set(hairetu, forKey: "Key")
        self.Table.reloadData()

        
        
    }
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let str = "あなたのSoCを登録しましょう。\nSoCは学校のメニューから登録できます"
        let font = UIFont.systemFont(ofSize: 14.0, weight: 2.0)
        return NSAttributedString(
            string: str,
            attributes: [NSFontAttributeName: font, NSForegroundColorAttributeName: UIColor.black]
        )
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "GoGo" {
            
            let secondViewController:TsuikaViewController = segue.destination as! TsuikaViewController
            secondViewController.Gakkou = hairetu
            
            
            
        }else{
            let secondViewController:SchoolMenuViewController = segue.destination as! SchoolMenuViewController
            secondViewController.schoolname = point
            secondViewController.id = id
        }
        
    }
}
