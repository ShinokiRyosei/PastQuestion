//
//  SetPlace.swift
//  PastQToRelease
//
//  Created by owner on 2016/08/02.
//  Copyright © 2016年 Yuki Yanagawa. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class SetPlaceViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    @IBOutlet var Table: UITableView!
    @IBOutlet var Table2: UITableView!
    @IBOutlet weak var PlaceLabel: UILabel!
    @IBOutlet weak var SchoolLael: UILabel!
    var hairetu: [String] = ["東京都","神奈川県","千葉県","埼玉県","栃木県","山梨県"]
    var hairetu2: [String] = [""]
    var kensakukouho: [String] = []
    var point: String!
    var id: String!
    
    var seach:String!
    let now = Date()
    let dateFormatter = DateFormatter()
    var hairetu3:[String] = []
    
    var snap: FIRDataSnapshot!
    let ref = FIRDatabase.database().reference()
    var Array:[FIRDataSnapshot] = []
    var step:Int! = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.tintColor = Color().mainColor()
        self.navigationController!.navigationBar.barTintColor = Color().koime()
        
        dateFormatter.dateFormat = "YYddHHmmSS"
        
        Table.delegate = self
        Table.dataSource = self
        Table2.delegate = self
        Table2.dataSource = self
        self.reload()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView.tag == 0{
            return hairetu.count
        }
        return hairetu2.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 0{
            let cell = Table.dequeueReusableCell(withIdentifier: "Cell") as! TableViewCellType1ViewController
            cell.PlaceLabel!.text = hairetu[(indexPath as NSIndexPath).row]
            return cell
        }else{
            let cell2 = Table2.dequeueReusableCell(withIdentifier: "SetSchool") as!
            TableViewCellType1ViewController
            cell2.SchoolLael!.text = hairetu2[(indexPath as NSIndexPath).row]
            return cell2
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if  tableView.tag == 0{
            if (indexPath as NSIndexPath).row == 0{
                hairetu2 = school().Tokyo()
            }
            if (indexPath as NSIndexPath).row == 1{
                hairetu2 = school().Knagawa()
            }
            if (indexPath as NSIndexPath).row == 2{
                hairetu2 = school().Chiba()
            }else if (indexPath as NSIndexPath).row == 3{
                hairetu2 = school().saitama()
            }else if (indexPath as NSIndexPath).row == 4{
                hairetu2 = school().Tochigi()
                
            }else if (indexPath as NSIndexPath).row == 5{
                hairetu2 = school().Yamanashi()
            }
            
            print(hairetu2)
            Table2.reloadData()
            
        }else{
            if hairetu2[(indexPath as NSIndexPath).row] == ""{
                
            }else{
                id = "\(dateFormatter.string(from: now))"
                point = hairetu2[(indexPath as NSIndexPath).row]
                print()
                self.performSegue(withIdentifier: "CheckData", sender: self)
            }
        }
    }
    
    @IBAction func sa(){
        let url = URL(string: "")
        if UIApplication.shared.canOpenURL(url!){
            UIApplication.shared.openURL(url!)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //テキストが更新されたときに呼ばれる
        seach = searchBar.text
        if seach == ""{
            
        }else{
            let index = hairetu2.index(of: seach)
            if index == nil{
            }else{
                kensakukouho.append(hairetu2[index!])
                hairetu = kensakukouho
                self.reload()
            }
        }
        
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        seach = searchBar.text
        searchBar.resignFirstResponder()
        
    }
    
    func read()  {
        //FIRDataEventTypeを.Valueにすることにより、なにかしらの変化があった時に、実行
        //今回は、childでユーザーIDを指定することで、ユーザーが投稿したデータの一つ上のchildまで指定することになる
        
        ref.child("SoCdata").queryOrdered(byChild: "user").queryEqual(toValue: (FIRAuth.auth()?.currentUser?.uid)!).observe(.value, with: {(snapShots) in
            if snapShots.children.allObjects is [FIRDataSnapshot] {
                print("snapShots.children...\(snapShots.childrenCount)")
                
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
    }
    
    func ashita() {
        
        //FIRDataSnapShotは辞書型なので取り出すこと
        for value in Array {
            
            let item = value.value as! Dictionary<String, AnyObject>
            print(item)
            let sa = item["school"] as! String
            let index = hairetu3.index(of: sa)
            if index == nil{
                hairetu3.append(sa)
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "CheckData" {
            
            let secondViewController:SchoolMenuViewController = segue.destination as! SchoolMenuViewController
            
            
            secondViewController.id = id
            secondViewController.schoolname = point
        }
        
    }
    
    func reload(){
        self.Table.reloadData()
        self.Table2.reloadData()
    }
    
}
