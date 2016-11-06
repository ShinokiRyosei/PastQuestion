//
//  KekkaViewController.swift
//  Pascue
//
//  Created by owner on 2015/11/27.
//  Copyright © 2015年 Yanack. All rights reserved.
//

import UIKit

class KekkaViewController: UIViewController {
    var Time:Int!
    @IBOutlet var TimeLabel:UILabel!
    let pasteboard = UIPasteboard.general
    override func viewDidLoad() {
        super.viewDidLoad()
       TimeLabel.text = "終了時間: \(String(Time))分"

        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
//    func kakikomi(){
//        TimeLabel.text = "経過時間 \(String(Time))分"
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
    
}
