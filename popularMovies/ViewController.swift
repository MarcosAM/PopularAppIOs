//
//  ViewController.swift
//  popularMovies
//
//  Created by posgrad on 09/11/2019.
//  Copyright © 2019 posgrad. All rights reserved.
//

import UIKit
import FirebaseAuth
import MaterialComponents.MaterialSnackbar

class ViewController: UIViewController {

    @IBOutlet weak var aiLoader: UIActivityIndicatorView!
    
    @IBOutlet weak var tfUser: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnSignin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        aiLoader.isHidden = true
    }
    
    @IBAction func onClickLogin(_ sender: UIButton) {
        setLoading(true)
        
        if let email = tfUser.text, let password = tfPassword.text {
            Auth.auth().signIn(withEmail: email, password: password, completion: { (result, error) in
                let message = MDCSnackbarMessage()
                
                if(error != nil) {
                    message.text = error?.localizedDescription
                } else {
                    message.text = "Welcome \(result?.user.email ?? "")"
                }
                
                self.setLoading(false)
                MDCSnackbarManager.show(message)
            })
        }
    }
    
    @IBAction func onClickSingin(_ sender: Any) {
        setLoading(true)
        
        if let email = tfUser.text, let password = tfPassword.text {
            Auth.auth().createUser(withEmail: email, password: password, completion: {(result, error) in
                let message = MDCSnackbarMessage()
                
                if(error != nil) {
                    message.text = error?.localizedDescription
                } else {
                    message.text = "Created user \(result?.user.email ?? "")"
                }
                
                self.setLoading(false)
                MDCSnackbarManager.show(message)
            })
        }
    }
    
    func setLoading(_ flag: Bool) {

        btnLogin.isHidden = flag
        btnSignin.isHidden = flag
        
        aiLoader.isHidden = !flag
    }
    
    /*@IBAction func onClick(_ sender: Any) {
        let http = URLSession.shared
        aiLoader.isHidden = false
        
        if let url = URL(string: "http://www.mocky.io/v2/5dc6c79e3800007b00cdec4a"){
            let request = URLRequest(url:url)
            let task = http.dataTask(with: request){(data,response,error) in
                DispatchQueue.main.async {
                    self.aiLoader.isHidden = true
                }
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                    let dict = json as! NSDictionary
                    
                    if let id = dict["id"] as? Int, let name = dict["name"] as? String {
                        let user = User(id: id, name: name)
                        print(user)
                    }
                } catch {
                    
                }
            }
            task.resume()
        }
    }*/
}
