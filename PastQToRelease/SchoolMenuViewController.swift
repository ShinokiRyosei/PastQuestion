//
//  SchoolMenuViewController.swift
//  PastQToRelease
//
//  Created by owner on 2016/08/02.
//  Copyright © 2016年 Yuki Yanagawa. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class SchoolMenuViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    @IBOutlet var sumlabel:UILabel!
    @IBOutlet var funjin:UILabel!
    @IBOutlet var picker:UIPickerView!
    @IBOutlet var maxLabel:UILabel!
    @IBOutlet var Table:UITableView!
    @IBOutlet var segcon:UISegmentedControl!
    let userDefaults:UserDefaults = UserDefaults.standard
    var Contentview: UIView!
    var sentaku:String!
    var points:[Int]=[]
    var schoolname:String!
    var Score:[String] = []
    var ranck:[String] = []
    var snap: FIRDataSnapshot!
    var id: String!
    var count:Int!
    var mode:Int!
    var SOCView:MySOCViewController=MySOCViewController()
    var sum: Int = 0
    let ref = FIRDatabase.database().reference()
    var SoCs:[String] = []
    
    
    var Array:[FIRDataSnapshot] = []
    @IBOutlet var schollLabel:String!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        SoCs = (userDefaults.object(forKey: "Key") as? [String])!

        for i in SoCs{
            if i == String(schoolname){
                
            }else{
                
            }
        }
        
        
        Table?.delegate=self
        Table?.dataSource = self
        picker!.delegate = self
        picker.dataSource = self
        segcon.addTarget(self, action:#selector(SchoolMenuViewController.segconChanged(segcon:)), for: UIControlEvents.valueChanged)
        
        for i in 0..<100{
            points.append(i)
        }
        
        
        funjin.text=schoolname
        
        //        self.navigationItem.hidesBackButton = true
        print(schoolname)
        self.read()
        // Do any additional setup after loading the view.
    }
    
    func read()  {
        //FIRDataEventTypeを.Valueにすることにより、なにかしらの変化があった時に、実行
        //今回は、childでユーザーIDを指定することで、ユーザーが投稿したデータの一つ上のchildまで指定することになる
        ref.child("Online").queryOrdered(byChild: "school").queryEqual(toValue: schoolname).observe(.value, with: {(snapShots) in
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
    //読み込んだデータは最初すべてのデータが一つにまとまっているので、それらを分割して、配列に入れる
    func reload(_ snap: FIRDataSnapshot) {
        //FIRDataSnapshotが存在するか確認
        if snap.exists() {
            Array.removeAll()
            
            //1つになっているFIRDataSnapshotを分割し、配列に入れる
            for item in snap.children {
                Array.append(item as! FIRDataSnapshot)
                
            }
        }
        print("配列は\(Array)")
        ashita()
    }
    
    func ashita(){
        
        var max: Int = 0
        
        //FIRDataSnapShotは辞書型なので取り出すこと
        for value in Array {
            
            let item = value.value as! Dictionary<String, AnyObject>
            print(item)
            
            let num = Int(item["Score"] as! String)!
            sum = sum + num
            if num > max{
                max = num
                print("最高が更新された\(max)")
                ranck.insert(String(max), at: 0)
            }
            if (String(item["user"] as! String) == (FIRAuth.auth()?.currentUser?.uid)!){
                Score.append(String(num))
            }
            print("平均\(sum)")
        }
        if sum == 0{
            let alert = UIAlertView(title: "\(String(schoolname)!)のデータが不足しています", message: "データ不足のため平均点が取得出来ませんでした。少しでも多くの方に利用していただけるように拡散お願いします", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        }else{
            sum = sum / Array.count
            //
            //            sumlabel.text = String("平均:\(sum)点")
            //            maxLabel.text = String("最高:\(max)点")
            
        }
        
    }
    
    @IBAction func select(){
        self.update()
    }
    func update() {
        if mode == 0{
            let alert = UIAlertView(title: "エラー", message: "再送信してください", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            
            
        }else{
            
            print("学校は\(schoolname)点数は\(sentaku)")
            ref.child("Online").child(id).updateChildValues(["Score": sentaku,"school": schoolname,"user": (FIRAuth.auth()?.currentUser?.uid)!])
            let alert = UIAlertView(title: "投稿完了", message: "誤入力の場合はお問い合わせフォームへご連絡ください。\n 正確なデータの出力にご協力をお願いします。", delegate: self, cancelButtonTitle: "OK")
            
            alert.show()
        }
    }
    
    @IBAction func SoC(){
        print("idは\(id)")
        ref.child("SoCdata").child(id).setValue(["school": schoolname,"user": (FIRAuth.auth()?.currentUser?.uid)!])
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        //        if segue.identifier == "post"{
        //            let secondViewController:ToukouViewController = segue.destination as! ToukouViewController
        //
        //
        //
        //            secondViewController.gakkouname = schoolname
        //            secondViewController.id = id
        //        }else{
        //            let secondViewController:PrivateViewController = segue.destination as! PrivateViewController
        //            secondViewController.gakkouname = schoolname
        //            secondViewController.Score = userScore
        //            secondViewController.id = id
        //            secondViewController.sum = sum
        //            secondViewController.ranck = top10
        //        }
        //
        //
        //    }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return Score.count
        
    }
    
    
    
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Table?.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let index = ranck.index(of: Score[(indexPath as NSIndexPath).row])
        let sai = (indexPath as NSIndexPath).row - sum
        if index == nil{
            cell?.textLabel!.text = "得点 \(Score[(indexPath as NSIndexPath).row]) 平均との差異\(sai) 頑張れ！"
        }else{
            cell?.textLabel!.text = "得点 \(Score[(indexPath as NSIndexPath).row]) ユーザー順位\(String(index! + 1))位 おめでとう！"
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func segconChanged(segcon: UISegmentedControl){
        
        switch segcon.selectedSegmentIndex {
        case 0:
            print("決定")
            picker.isHidden = true
            Table?.isHidden = false
            picker.isHidden = true
            mode=0
        case 1:
            print("Tokou")
            let alert = UIAlertView(title: "確認", message: "入力データは全教科合計点です。", delegate: self, cancelButtonTitle: "OK")
            
            alert.show()
            Table?.isHidden = true
            picker.isHidden = false
            mode=1
            Table?.reloadData()
            
        case 2:
            Table?.isHidden = false
            picker.isHidden = true
            mode=2
        default:
            Table?.isHidden = false
            picker.isHidden = true
            mode=0
            Table?.reloadData()
            
        }
    }
}


extension SchoolMenuViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    //表示個数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if component == 0{
            return points.count
        }else{
            return points.count
        }
    }
    
    //表示内容
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0{
            return String(points[row])
        }else{
            return String(points[row])
        }
    }
    
    //選択時
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        sentaku = String(points[row])
    }
    
}
