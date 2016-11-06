//
//import UIKit
//import AVFoundation
//class AnalogViewController: UIViewController {
//    
//    
//    //AppDelegateのインスタンスを取得
//    
//    @IBOutlet var label: UILabel!
//    @IBOutlet var hariB: UIImageView!
//    @IBOutlet var hariF: UIImageView!
//    @IBOutlet var harij: UIImageView!
//    var angleintF:Int!
//    var mode3:Int = 0
//    var angleintB = 270
//    var  anguleintJ:Int!
//    var count: Float = 0.0
//    var timer: Timer = Timer()
//    @IBOutlet var minutsLabel: UILabel!
//    var count2: Float = 0
//    var countMain: Float = 0
//    var clockB:Int = 45
//    var clockF:Int = 59
//    var clockJ:Int = 8
//    var minutes:Float = 60
//    var Nokorizikan:Int!
//    var player = AVAudioPlayer()
//    var Seigenzikan:Int!
//    var Syuryozikan:Int!
//    var mode:Int = 3
//    var check:Int = 0
//    let T: [Int] = [9,10,11]
//    let StartTime = Int(arc4random() % Int32(3))
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        Syuryozikan = 0
//        
//        
//        clockJ = T[StartTime] - 1
//        
//        //        var textfoShibouku = let fileURL : NSURL =
//        
//        
//        
//        // Do any additional setup after loading the view, typically from a nib.
//    }
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    @IBAction func start(){
//        if !timer.isValid{
//            //タイマーが作動していなっから動かす。
//            timer = Timer.scheduledTimer(timeInterval: 1,
//                                                           target: self,
//                                                           selector: #selector(ViewController.up),
//                                                           userInfo: nil,
//                                                           repeats: true
//            )
//            
//            mode = 0
//            
//        }
//    }
//    
//
//    
//    func up() {
//        //countを0.01(時間分）足す
//        
//        print("upファンクション到達")
//        countMain = countMain + 1
//        if countMain > 15{
//            print("count \(count) countMain\(countMain)")
//            count = count + 1
//            
//        }
//        clockB = clockB + 1
//        let angleB:CGFloat = CGFloat(2 * M_PI * Double(clockB) / 60)
//        let angleF:CGFloat = CGFloat(2 * M_PI * Double(clockF) / 60)
//        let angleJ:CGFloat = CGFloat(2 * M_PI * Double(clockJ) / 12)
//        angleintB = angleintB + 6
//        print("85行目まで正常")
//        
//        if clockB == 60{
//            clockF = clockF + 1
//            clockB = 0
//            if clockF == 60{
//                clockJ = clockJ + 1
//                clockF = 0
//            }
//            //            hariB.transform = CGAffineTransformMakeRotation(angleF)
//        }
//        hariB.transform = CGAffineTransform(rotationAngle: angleB)
//        hariF.transform = CGAffineTransform(rotationAngle: angleF)
//        harij.transform = CGAffineTransform(rotationAngle: angleJ)
//        print("92行目まで到達")
//        //        label.text = "\(String(clockJ))：\(String(clockF))：\(String(clockB))"
//        Nokorizikan = Seigenzikan - Int(count2)
//        self.labelaction()
//    }
//    
//    func labelaction(){
//        if count == 60 {
//            count = 0
//            count2 = count2 + 1
//            minutsLabel.text = "\(String(format: "%.f",count2))min left"
//        }
//        
//        
//        if count.truncatingRemainder(dividingBy: 5) == 0{
//            self.labelmode()
//        }else if count == 0{
//            minutsLabel.text = "試験開始は \(String(T[StartTime])):00です。"
//        }
//        if Nokorizikan == 0{
//            check = 2
//            let alert = UIAlertView(title: "時間終了", message: "時間終了です。", delegate: self, cancelButtonTitle: "OK")
//            alert.show()
//        }
//        
//    }
//    
//    func labelmode(){
//        if count == 0{
//            minutsLabel.text = "試験開始は \(String(T[StartTime])):00です。"
//        }else if mode == 1{
//            minutsLabel.text = "\(String(format: "%.f",count2))min gone "
//            mode = 0
//        }else{
//            minutsLabel.text = "\(String(Nokorizikan))min left "
//            mode = 1
//        }
//    }
//
//    @IBAction func hyozi() {
//        self.labelmode()
//    }
//    @IBAction func Syuryo(){
//        Syuryozikan = Int(count2)
//        check = 1
//        timer.invalidate()
//        //        print("終了時間\(count2)チェックIntの値\(check)")
//        performSegue(withIdentifier: "ki",sender: nil)
//    }
//    
////    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
////        let viewController:KekkaViewController = segue.destinationViewController as! KekkaViewController
////        viewController.Time = self.Syuryozikan
////    }
//}
