//
//  CadastroViewController.swift
//  Snapchat
//
//  Created by Enzo on 18/10/23.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class CadastroViewController: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var nomeCompleto: UITextField!
    @IBOutlet weak var senha: UITextField!
    @IBOutlet weak var senhaConfirmacao: UITextField!
    
    func exibirMensagem(titulo: String, mensagem: String ) {
        
        let alerta = UIAlertController(title: titulo, message: mensagem, preferredStyle: .alert)
        let acaoCancelar =  UIAlertAction(title: "cancelar" , style: .cancel , handler: nil)
        
        alerta.addAction(acaoCancelar)
        present(alerta, animated: true, completion: nil)
    }
    
    @IBAction func criarConta(_ sender: Any) {
        
        //Recuperar Dados
        if let emailR = self.email.text {
            if let nomeCompletoR = self.nomeCompleto.text {
                if let senhaR = self.senha.text {
                    if  let senhaConfirmacaoR = self.senhaConfirmacao.text {
                        
                        //Validar Senha
                        if senhaR == senhaConfirmacaoR {
                            
                            //Criar conta no Firebase
                            let  autenticacao = Auth.auth()
                            autenticacao.createUser(withEmail: emailR, password: senhaR, completion: { (usuario,erro) in
                                if erro == nil {
                                    
                                    if usuario == nil {
                                        self.exibirMensagem(titulo: "Erro ao autenticar", mensagem: "Problema ao realizar autenticacao, tente novamente.")
                                        let autenticacao = Auth.auth()
                                               
                                        let database = Database.database().reference()
                                                        let usuarios = database.child("usuarios")
                                                        let usuarioDados = ["nome": nomeCompletoR, "email": emailR]
                                                        
                                        
                                        
                                                            
                                    
                                        //redireciona usuario para  tela principal
                                        self.performSegue(withIdentifier: "cadastrologinSegue", sender: nil)
                                    }
                                    
                                    /*
                                     ERROR_INVALID_EMAIL
                                     */
                                    
                                    let erroR = erro! as NSError
                                    if let codigoErro = erroR.userInfo["error_name"] {
                                        
                                        let erroTexto = codigoErro as! String
                                        var mensagemErro = ""
                                        
                                        switch erroTexto {
                                            
                                            
                                        case "ERROR_WEAK_PASSWORD" :
                                            mensagemErro = "Senha no minimo, precisa ter 6 caracteres, com letras e numeros"
                                            break
                                        case  "ERROR_EMAIL_ALREADY_IN_USE" :
                                            mensagemErro = "Esse email já esta sendo  utilizado,  crie sua conta com outro email"
                                            break
                                        default:
                                            mensagemErro = "Dados digitados estao incorretos"
                                            
                                            
                                        }
                                        self.exibirMensagem(titulo: "Dados invalidos", mensagem: mensagemErro)
                                        
                                    }
                                    
                                }/*Fim Validacao erro Firebase*/
                                
                            })
                            
                        }else{
                            self.exibirMensagem(titulo: "Dados incorretos", mensagem: "As senhas não estão iguais, digite  novamente.")
                        }/*Fim Validacao senha*/
                        
                        
                    }
                }
            }
            
        }
        
    } /*Fechamento metodo criar conta*/
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

