//
//  ViewController.swift
//  RandomImage
//
//  Created by Tercio Brandão Cavalcanti on 20/06/24.
//

import UIKit

class ViewController: UIViewController {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .white
        return imageView
        
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Random Photo", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        return button
        
    }()
    
    let colors: [UIColor] = [
        .systemRed,
        .systemOrange,
        .systemGreen,
        .systemYellow,
        .systemBlue,
        .systemTeal,
        .systemCyan,
        .systemMint
        
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemPink
        view.addSubview(imageView)
        imageView.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        imageView.center = view.center
        
        view.addSubview(button)
        getRandomPhoto()
        
        button.addTarget(self, action: #selector(btnTap), for: .touchUpInside)
    }
    
    @objc func btnTap(){
        getRandomPhoto()
        
        view.backgroundColor = colors.randomElement()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        button.frame = CGRect(
            x: 30,
            y: view.frame.height-150-view.safeAreaInsets.bottom,
            width: view.frame.size.width-60,
            height: 55
        )
        
    }
    
    func getRandomPhoto() {
            let urlString = "https://picsum.photos/600/600"
            guard let url = URL(string: urlString) else {
                print("Invalid URL")
                return
            }
            
            // Use URLSession para carregar os dados de forma assíncrona
            let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                // Verifique se ocorreu algum erro
                if let error = error {
                    print("Failed to load data from URL: \(error)")
                    return
                }
                
                // Verifique se os dados são válidos
                guard let data = data, let image = UIImage(data: data) else {
                    print("Failed to convert data to image")
                    return
                }
                
                // Atualize a interface do usuário no thread principal
                DispatchQueue.main.async {
                    self?.imageView.image = image
                }
            }
            
            // Inicie a tarefa de carregamento de dados
            task.resume()
        }
}

    
