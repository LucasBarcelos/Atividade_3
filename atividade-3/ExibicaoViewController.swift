//
//  ExibicaoViewController.swift
//  atividade-3
//
//  Created by Lucas Barcelos on 11/01/22.
//

import UIKit

class ExibicaoViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var nomeLabel: UITextField!
    @IBOutlet weak var localizacaoLabel: UITextField!
    @IBOutlet weak var descricaoTextView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - Properties
    var problema: Problema?
    
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configLayout()
    }

    // MARK: - Methods
    func configLayout() {
        if let nome = problema?.nome,
            let endereco = problema?.endereco,
            let descricao = problema?.descricao,
            let imagem = problema?.imagem {
            nomeLabel.text = nome
            localizacaoLabel.text = endereco
            descricaoTextView.text = descricao
            imageView.image = UIImage(data: imagem)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "edicao" {
            if let vc = segue.destination as? CadastroEdicaoViewController {
                vc.problema = problema
                vc.edicao = true
            }
        }
    }
}

