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
    var edicao: Bool?
    var currentDateTime = Date()
    let formatter = DateFormatter()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configLayout(edicao ?? false)
        
    }
    
    // MARK: - Methods
    func selectPicture(sourceType: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    func configLayout(_ edicao: Bool) {
        if edicao {
            if let nome = problema?.nome,
                let endereco = problema?.endereco,
                let descricao = problema?.descricao,
                let imagem = problema?.imagem {
                nomeLabel.text = nome
                enderecoLabel.text = endereco
                descricaoTextView.text = descricao
                imageView.image = UIImage(data: imagem)
                self.navigationItem.title = "Edição"
            }
        } else {
            self.navigationItem.title = "Cadastro"
        }
    }
    
    func alertDismiss() {
        guard let edicao = self.edicao else { return }
        if edicao {
            let alert = UIAlertController(title: "Edição", message: "Sua edição foi realizada com sucesso!", preferredStyle: .alert)
            
            let okButton = UIAlertAction(title: "Ok", style: .default) { UIAlertAction in
                self.navigationController?.popToRootViewController(animated: true)
            }
            alert.addAction(okButton)
            present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Cadastro", message: "Seu cadastro foi realizado com sucesso!", preferredStyle: .alert)
            
            let okButton = UIAlertAction(title: "Ok", style: .default) { UIAlertAction in
                self.navigationController?.popViewController(animated: true)
            }
            alert.addAction(okButton)
            present(alert, animated: true, completion: nil)
        }
    }
    
    func configHoraData() -> String {
        formatter.timeStyle = .short
        formatter.dateStyle = .short
        return formatter.string(from: currentDateTime)
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
        problema?.data = configHoraData()
        
        try? context.save()
        alertDismiss()
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

extension CadastroEdicaoViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

