//
////
////  SentakuViewController.swift
////  Pascue
////
////  Created by owner on 2015/11/24.
////  Copyright © 2015年 Yanack. All rights reserved.
////
//
//import UIKit
//
//class SentakuViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
//    //    @IBOutlet var Zyukenkou: UITableView!
//    @IBOutlet var Syudounyuryoku: UILabel!
//    @IBOutlet var Picker: UIPickerView?
//    var Seigenzikan: Int! = 0
//    var ZyukenkokuKyoukaArray = [String]()
//    var ZyukenkirokuKyokaInt = [Int]()
//    var Sentaku: String!
//    var a:Int! = 0
//    var Nom:Int! = 0
//    var clock:[String] = ["デジタル時計（通常モード）","アナログ時計（通常モード）"]
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.navigationController!.navigationBar.tintColor = Color().mainColor()  // バーアイテムカラー
//        self.navigationController!.navigationBar.barTintColor = Color().koime()
//        Picker?.delegate = self
//        Picker?.dataSource = self
//
//    }
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        
//        // Dispose of any resources that can be recreated.
//    }
//
//    
//    @IBAction func plus10(){
//        Seigenzikan = Seigenzikan + 10
//        self.kakikomi()
//    }
//    @IBAction func plus5(){
//        Seigenzikan = Seigenzikan + 5
//        self.kakikomi()
//    }
//    @IBAction func set60(){
//        Seigenzikan = Seigenzikan + 60
//        self.kakikomi()
//    }
//    @IBAction func reset(){
//        Seigenzikan = 0
//        self.kakikomi()
//    }
//    func kakikomi(){
//        Syudounyuryoku.text = " Timer　\(String(Seigenzikan))min"
//        
//    }
//    @IBAction func ke(){
//        if Seigenzikan == 0{
//       
//                let alert = UIAlertView(title: "Timer is not set", message: "Set the timer", delegate: self, cancelButtonTitle: "OK")
//                alert.show()
//            
//
//        }else if Seigenzikan < 500{
//            if Nom == 0{
//                performSegue(withIdentifier: "o",sender: nil)
//            }else{
//                performSegue(withIdentifier: "k",sender: nil)
//            }
//        }else{
//            let alert = UIAlertView(title: "この時間はセットできません", message: "PastTimerは上限1000分に設定されてます", delegate: self, cancelButtonTitle: "OK")
//            alert.show()
//        }
//    }
//    //   func ko(){
//    //        if Seigenzikan == 0{
//    //            let alert = UIAlertView(title: "Timer is not set", message: "Set the timer", delegate: self, cancelButtonTitle: "OK")
//    //            alert.show()
//    //
//    //        }else{
//    //            performSegueWithIdentifier("k",sender: nil)
//    //        }
//    //    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
//        
//        if segue.identifier == "o"{
//            let viewController:ViewController = segue.destination as! ViewController
//            viewController.Seigenzikan = self.Seigenzikan
//        }else if segue.identifier == "k"{
//            let viewController2:AnalogViewController = segue.destination as! AnalogViewController
//            viewController2.Seigenzikan = self.Seigenzikan
//        }else{
//           
//        }
//        
//    }
//    func numberOfComponents(in pickerView: UIPickerView!) -> Int {
//        return 1
//    }
//    
//    func pickerView(_ pickerView: UIPickerView!, numberOfRowsInComponent component: Int) -> Int{
//        
//        return clock.count
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
//        
//        return"\(clock[row])"
//        
//    }
//    
//    
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        Nom = row
//        //        self.ke()
//        
//        
//    }
//    
//    /*
//     // MARK: - Navigation
//     
//     // In a storyboard-based application, you will often want to do a little preparation before navigation
//     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//     // Get the new view controller using segue.destinationViewController.
//     // Pass the selected object to the new view controller.
//     }
//     */
//}
