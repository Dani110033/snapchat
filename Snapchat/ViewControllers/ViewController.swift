//
//  ViewController.swift
//  Snapchat
//
//  Created by Enzo on 18/10/23.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let autenticacao = Auth.auth()
        
        do{
            try autenticacao.signOut()
        }catch {
            print("Erro ao deslogar o usuario")
            
        }
        autenticacao.addStateDidChangeListener { (autenticacao, usuario) in
            if usuario != nil{
                self.performSegue(withIdentifier: "loginAutomaticoSegue", sender: nil)
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }



}
