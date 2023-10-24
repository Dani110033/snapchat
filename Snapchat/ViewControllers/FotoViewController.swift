//
//  FotoViewController.swift
//  Snapchat
//
//  Created by Enzo on 19/10/23.
//

import UIKit
import FirebaseStorage

class FotoViewController: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    
    @IBOutlet weak var imagem: UIImageView!
    @IBOutlet weak var descricao: UITextField!
    @IBOutlet weak var botaoProximo: UIButton!
    
    
    var imagePicker = UIImagePickerController ()
    var IdImagem = NSUUID().uuidString
    
    
    @IBAction func proximoPasso(_ sender: Any) {
        
        self.botaoProximo.isEnabled = false
        self.botaoProximo.setTitle("Carregando.." , for: .normal)
    
       let armazenamento = Storage.storage().reference()
        let imagens = armazenamento.child("imagens")
        
        
            //Recuperar a imagem
        if let imagemSelecionada = imagem.image {
            
            if let imagemDados = imagemSelecionada.jpegData(compressionQuality: 0.1) {
                imagens.child("\(self.IdImagem).jpg").putData(imagemDados, metadata: nil, completion: { (metaDados, erro) in
                    
                    
                    if erro == nil {
            
                        print("Sucesso ao fazer o upload do arquivo")
                        return
                        
                       // let url = metaDados?.downloadURL()?.absoluteString
                        //self.performSegue(withIdentifier: "selecionarUsuarioSegue", sender: url)
                        
                              self.botaoProximo.isEnabled = true
                              self.botaoProximo.setTitle("Proximo", for: .normal)
                              
                        }else{
                        //print("Erro ao fazer  upload do arquivo")
                            let alerta = Alerta(titulo: "Uploud falhou", mensagem: "Erro ao salvar o arquivo tente novamente")
                            self.present(alerta.getAlerta(), animated: true  , completion: nil )
                      }
                    })
                            
            }
        }
    }
                                                    
    @IBAction func selecionarFoto(_ sender: Any) {
        
        imagePicker.sourceType = .savedPhotosAlbum
        present(imagePicker, animated: true, completion: nil)
        
    }
        
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let imagemRecuperada = info[ UIImagePickerController.InfoKey.originalImage ] as! UIImage
        
        imagem.image = imagemRecuperada
        
        //Habilitar obotaao proximo
        self.botaoProximo.isEnabled = true
        self.botaoProximo.backgroundColor = UIColor(red: 0.553, green: 0.369, blue: 0.749, alpha: 1 )
        
        imagePicker.dismiss(animated: true, completion: nil)
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        
        //Desabilitar o botao Proxino
        botaoProximo.isEnabled = false
        botaoProximo.backgroundColor = UIColor.gray
        
    }
    
    
    
    // Do any additional setup after loading the view.

    
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
