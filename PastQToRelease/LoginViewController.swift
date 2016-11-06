//
//  LoginViewController.swift
//  PastQToRelease
//
//  Created by owner on 2016/08/03.
//  Copyright © 2016年 Yuki Yanagawa. All rights reserved.
//

import UIKit
import Firebase
class LoginViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet var emailTextField:UITextField!
    @IBOutlet var passwordTextField:UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        if FIRAuth.auth()?.currentUser != nil{
 self.performSegue(withIdentifier: "Login", sender: self)
        }
        emailTextField.delegate = self //デリゲートをセット
        passwordTextField.delegate = self //デリゲートをセット
        // Do any additional setup after loading the view.
    }
    @IBAction func DoLogin(){
        self.login()
    }
    @IBAction func Dosignup(){
        self.signup()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func signup() {
        //emailTextFieldとpasswordTextFieldに文字がなければ、その後の処理をしない
        guard let email = emailTextField.text else  { return }
        guard let password = passwordTextField.text else { return }
        
        //FIRAuth.auth()?.createUserWithEmailでサインアップ
        //第一引数にEmail、第二引数にパスワード
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            //エラーなしなら、認証完了
            if error == nil{
                self.performSegue(withIdentifier: "Login", sender: self)
            }else {
                let alert = UIAlertView(title: "エラー", message: "新規作成失敗 Reason\(error)", delegate: self, cancelButtonTitle: "OK")
                alert.show()
            }
        })
    }
    func login() {
        //EmailとPasswordのTextFieldに文字がなければ、その後の処理をしない
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        //signInWithEmailでログイン
        //第一引数にEmail、第二引数にパスワードを取ります
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            //エラーなしなら、ログイン完了
            if error == nil{
                self.performSegue(withIdentifier: "Login", sender: self)
            }else {
    let alert = UIAlertView(title: "エラー", message: "ログイン失敗 Reason\(error)", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            }
        })
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
