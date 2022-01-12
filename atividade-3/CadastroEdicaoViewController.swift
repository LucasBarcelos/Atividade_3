//
//  CadastroEdicaoViewController.swift
//  atividade-3
//
//  Created by Lucas Barcelos on 11/01/22.
//

import UIKit

class CadastroEdicaoViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var nomeLabel: UITextField!
    @IBOutlet weak var enderecoLabel: UITextField!
    @IBOutlet weak var descricaoTextView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cancelarButton: UIButton!
    @IBOutlet weak var salvarButton: UIButton!
    
    // MARK: - Properties
    var problema: Problema?
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Methods
    func selectPicture(sourceType: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    // MARK: - Actions
    @IBAction func cancelarButton(_ sender: UIButton) {
        let alert = UIAlertController(title: "Cancelar", message: "Você tem certeza que deseja cancelar este cadastro?", preferredStyle: .actionSheet)
        
        let sim = UIAlertAction(title: "Sim", style: .default) { UIAlertAction in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(sim)
        
        let nao = UIAlertAction(title: "Não", style: .cancel, handler: nil)
        alert.addAction(nao)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func salvarButton(_ sender: UIButton) {
        if problema == nil {
            problema = Problema(context: context)
        }
        problema?.nome = nomeLabel.text
        problema?.endereco = enderecoLabel.text
        problema?.descricao = descricaoTextView.text
        problema?.imagem = imageView.image?.jpegData(compressionQuality: 0.9)
        
        try? context.save()
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func carregarImagem(_ sender: UIButton) {
        let alert = UIAlertController(title: "Selecionar imagem", message: "De onde você desejar escolher a imagem?", preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Câmera", style: .default) { (_) in
                self.selectPicture(sourceType: .camera)
            }
            alert.addAction(cameraAction)
        }
        
        let libraryAction = UIAlertAction(title: "Biblioteca de fotos", style: .default) { (_) in
            self.selectPicture(sourceType: .photoLibrary)
        }
        alert.addAction(libraryAction)
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
}

extension CadastroEdicaoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
 
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.originalImage] as? UIImage {
            imageView.image = image
        }
        
        dismiss(animated: true, completion: nil)
        
    }
}

