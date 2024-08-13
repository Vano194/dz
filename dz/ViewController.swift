//
//  ViewController.swift
//
//  dz
//  let API = "https://picsum.photos/200/300"
//  Created by Иван Галиченко on 07.08.2024.
//
import SnapKit
import UIKit

final class ViewController: UIViewController,UITextFieldDelegate {

    let myButton = UIButton(type: .system)
    let myImage = UIImageView()
    var mytextField = UITextField()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configureButton()
        configureImageView()
        
      
        textField()
       
        
        func textField() {
            let mytextFieldFframe =  CGRect(x: 0, y: 0, width: 200, height: 31)
            mytextField = UITextField(frame: mytextFieldFframe)
            mytextField.textColor = UIColor.black
            mytextField.borderStyle = .roundedRect
            mytextField.textAlignment = . center
            mytextField.placeholder = "write keyword like cat"
            mytextField.center = self.view.center
            mytextField.delegate = self
            mytextField.isHidden = true
            view.addSubview(self.mytextField)
            let tapToView = UITapGestureRecognizer(target: self, action: #selector(hideTextField))
                    view.addGestureRecognizer(tapToView)
        // я так и не понял почему textField не убирается при нажатии просто на вью хз что не так с функцией
            
        }
        
    }
    
    @objc func hideTextField() {
        mytextField.isHidden = false
        mytextField.resignFirstResponder()
        }
    @objc func showTextField() {
        mytextField.isHidden = false
        mytextField.becomeFirstResponder()
        }
    @objc   func textFieldShouldReturn(_ mytextField: UITextField) -> Bool {
        mytextField.resignFirstResponder()
        mytextField.isHidden = true
            return true
        }




    
    private func configureButton() {
        myButton.frame = CGRect(x: 120, y: 600, width: 150, height: 150)
        myButton.layer.cornerRadius = 0.5 * myButton.bounds.size.width
        myButton.setTitle("press me", for: .normal)
        myButton.backgroundColor = UIColor.blue
        myButton.layer.shadowColor = UIColor.green.cgColor
        myButton.layer.shadowOffset = CGSize(width: 0.5, height: 5.0)
        myButton.layer.shadowRadius = 9.0
        myButton.layer.shadowOpacity = 0.8
        myButton.layer.masksToBounds = false
        myButton.addTarget(self, action: #selector(getImage), for: .touchUpInside)
        myButton.addTarget(self, action: #selector(showTextField), for: .touchUpInside)
        
        view.addSubview(myButton)
    }
    
    
   

    @objc private func getImage() {
        
        guard let keyword = mytextField.text?.lowercased(), !keyword.isEmpty else {
            print("Keyword is empty")
            return
        }
  
        let API = "https://loremflickr.com/320/240\(keyword.lowercased())"
       
        guard let apiURL = URL(string: API) else {
            fatalError("Some error")
        }
       
        weak   var session = URLSession(configuration: .default)
    
        weak   var task = session?.dataTask(with: apiURL) {(data, response, error) in
      
            guard let data = data,  error == nil else { return }
            DispatchQueue.main.async {
           
                self.myImage.image = UIImage( data: data)
            }
            
        }
      
        task?.resume()

  }
    
    
    private func configureImageView() {
        myImage.snp.makeConstraints { make in
            view.addSubview(myImage)
           
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().inset(50)
            make.height.equalTo(150)
                        myImage.layer.shadowColor = UIColor.red.cgColor
                        myImage.layer.shadowOffset = CGSize(width: 0.5, height: 5.0)
                        myImage.layer.shadowRadius = 9.0
                        myImage.layer.shadowOpacity = 0.8
                        myImage.layer.masksToBounds = false


        }
       
       
    }
  
    
}
