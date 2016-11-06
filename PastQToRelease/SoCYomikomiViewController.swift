////
////  SoCYomikomiViewController.swift
////  PastQToRelease
////
////  Created by owner on 2016/09/25.
////  Copyright © 2016年 Yuki Yanagawa. All rights reserved.
////
////
////  MySOCViewController.swift
////  PastQToRelease
////
////  Created by owner on 2016/08/15.
////  Copyright © 2016年 Yuki Yanagawa. All rights reserved.
////
//
//import UIKit
//import Firebase
//import FirebaseDatabase
//
//
//class SOC {
//    var hairetu3:[String] = []
//    var id: String!
//    let dateFormatter = DateFormatter()
//    let now = Date()
//    var snap: FIRDataSnapshot!
//    var point: String!
//    let ref = FIRDatabase.database().reference()
//    var Array:[FIRDataSnapshot] = []
//
//
//    func read()  {
//        //FIRDataEventTypeを.Valueにすることにより、なにかしらの変化があった時に、実行
//        //今回は、childでユーザーIDを指定することで、ユーザーが投稿したデータの一つ上のchildまで指定することになる
//        
//        ref.child("SoCdata").queryOrdered(byChild: "user").queryEqual(toValue: (FIRAuth.auth()?.currentUser?.uid)!).observe(.value, with: {(snapShots) in
//            if snapShots.children.allObjects is [FIRDataSnapshot] {
//                print("snapShots.children...\(snapShots.childrenCount)")
//                //いくつのデータがあるかプリント
//                
//                print("snapShot...\(snapShots)")
//                //読み込んだデータをプリント
//                
//                self.snap = snapShots
//            }
//            self.reload(self.snap)
//        })
//    }
//    func reload(_ snap: FIRDataSnapshot) {
//        //FIRDataSnapshotが存在するか確認
//        if snap.exists() {
//            Array.removeAll()
//            
//            //1つになっているFIRDataSnapshotを分割し、配列に入れる
//            for item in snap.children {
//                Array.append(item as! FIRDataSnapshot)
//                
//            }
//        }
//    }
//    
//    
//    func ashita() -> [String]{
//        
//        //FIRDataSnapShotは辞書型なので取り出すこと
//        for value in Array {
//            
//            let item = value.value as! Dictionary<String, AnyObject>
//            print(item)
//            let sa = item["school"] as! String
//            let index = hairetu3.index(of: sa)
//            if index == nil{
//            hairetu3.append(sa)
//            }
//        }
//        
//        
//    }

    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
//}
