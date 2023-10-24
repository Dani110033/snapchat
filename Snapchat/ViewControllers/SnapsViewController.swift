//
//  SnapsViewController.swift
//  Snapchat
//
//  Created by Enzo on 19/10/23.
//

import UIKit
import FirebaseAuth

class SnapsViewController: UIViewController {
    
    @IBAction func sair(_ sender: Any) {
        
        let autenticacao = Auth.auth()
        do {
            try autenticacao.signOut()
            dismiss(animated: true, completion: nil)
        } catch {
            print("Erro ao deslogar o usuario")
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
         
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

//}
}
