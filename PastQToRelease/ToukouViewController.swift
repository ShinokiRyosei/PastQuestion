//
//  ToukouViewController.swift
//  PastQToRelease
//
//  Created by owner on 2016/08/05.
//  Copyright © 2016年 Yuki Yanagawa. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ToukouViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    @IBOutlet var Picker: UIPickerView? = UIPickerView()
    @IBOutlet var label: UILabel!
    var points:[Int] = []
    var id:String!
    var sentaku:String!
    var gakkouname:String!
    let ref = FIRDatabase.database().reference()
    var selectedSnap: FIRDataSnapshot!
    var isCreate = true
    override func viewDidLoad() {
        super.viewDidLoad()
        print("idは\(id)")
        label.text = gakkouname
        Picker?.dataSource = self
        Picker?.delegate = self
        for i in 0..<10000{
            points.append(i)
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //表示個数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return points.count
    }
    
    //表示内容
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String {
        return String(points[row])
    }
    
    //選択時
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        sentaku = String(points[row])
    }
    @IBAction func select(){
        self.update()
    }
    func update() {
        if sentaku == nil{
                 let alert = UIAlertView(title: "エラー", message: "再送信してください", delegate: self, cancelButtonTitle: "OK")
            
        
        
        }else{
        
        print("学校は\(gakkouname)点数は\(sentaku)")
        ref.child("Online").child(id).updateChildValues(["Score": sentaku,"school": gakkouname,"user": (FIRAuth.auth()?.currentUser?.uid)!])
                let alert = UIAlertView(title: "投稿完了", message: "誤入力の場合はお問い合わせフォームへご連絡ください。\n 正確なデータの出力にご協力をお願いします。", delegate: self, cancelButtonTitle: "OK")
        
        alert.show()
        }
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
