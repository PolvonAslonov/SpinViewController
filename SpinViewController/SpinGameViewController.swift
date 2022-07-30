//
//  SpinGameViewController.swift
//  SpinViewController
//
//  Created by user on 23/07/22.
//

import UIKit

class SpinGameViewController: UIViewController {
    private var viewone : UIView!
    private var viewtwo : UIView!
    private var viewthree : UIView!
    private var scorelabel : UILabel!
    private var label1 : UILabel!
    private var label2 : UILabel!
    private var label3 : UILabel!
    private var countscore : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
    // let img = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
//        img.image = UIImage(named: "Usa")
//        view.addSubview(img)
        self.initViews()
   
    
    }
    

    func initViews(){
        viewone = UIView(frame: CGRect(x: 50, y: 200, width: 90, height: 90))
        viewone.backgroundColor = .blue
        view.addSubview(viewone)
        scorelabel = UILabel(frame: CGRect(x: 150, y: 50, width: 100, height: 50))
        scorelabel.text = "Score: "
        scorelabel.textColor = .white
        scorelabel.font = .boldSystemFont(ofSize: 20)
        view.addSubview(scorelabel)
        viewtwo = UIView(frame: CGRect(x: 150, y: 200, width: 90, height: 90))
        viewtwo.backgroundColor = .red
        view.addSubview(viewtwo)
        
        viewthree = UIView(frame: CGRect(x: 250, y: 200, width: 90, height: 90))
        viewthree.backgroundColor = .yellow
        view.addSubview(viewthree)
        
        label1 = UILabel(frame: CGRect(x: 0, y: 0, width: viewtwo.frame.width, height: viewtwo.frame.height))
        label1.textAlignment = .center
        label1.textColor = .black
        label1.text = ""
        label1.font = .boldSystemFont(ofSize: 60)
        viewone.addSubview(label1)
        
        label2 = UILabel(frame: CGRect(x: 0, y: 0, width: viewtwo.frame.width, height: viewtwo.frame.height))
        label2.textAlignment = .center
        label2.textColor = .black
        label2.text = ""
        label2.font = .boldSystemFont(ofSize: 60)
        viewtwo.addSubview(label2)
        
        label3 = UILabel(frame: CGRect(x: 0, y: 0, width: viewtwo.frame.width, height: viewtwo.frame.height))
        label3.textAlignment = .center
        label3.textColor = .black
        label3.text = ""
        label3.font = .boldSystemFont(ofSize: 60)
        viewthree.addSubview(label3)
        
        let button = UIButton(frame: CGRect(x: 130, y: viewtwo.frame.maxY + 50, width: 120, height: 50))
        button.setTitle("Spin", for: .normal)
        button.backgroundColor = .red
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(onPress(_:)), for: .touchUpInside)
        view.addSubview(button)
        
    }

    private func clear(){
        label1.text = ""
        label2.text = ""
        label3.text = ""
    }
    private func alertfunction(){
        let alert = UIAlertController(title: "WOOW", message: "Siz Yutdingiz bro!", preferredStyle: .alert)
        let okBtn = UIAlertAction(title: "OK", style: .default){ action in
            self.clear()
            self.countscore += 1
            self.scorelabel.text = "Score: \(self.countscore)"
           }
        let nextBtn = UIAlertAction (title: "Next", style: .default)
        {_ in
            self.navigationController?.pushViewController(NextViewController(), animated: true)
        }
       
        
        alert.modalPresentationStyle = .fullScreen
        present(alert, animated: true)
        alert.addAction(okBtn)
        alert.addAction(nextBtn)
    }
    @objc func onPress(_ sender: UIButton){
        self.label1.text = "\(Int.random(in: 1 ... 4))"
        self.label2.text = "\(Int.random(in: 1 ... 4))"
        self.label3.text = "\(Int.random(in: 1 ... 4))"
        if let value1 = label1.text , let value2 = label2.text , let value3 = label3.text{
            if value1 == value2 && value1 == value3{
                alertfunction()
            }
        }
//        if label3.text == 4{
//            print("fjb")
//        }
    }

}
