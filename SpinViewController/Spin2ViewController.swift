//
//  Spin2ViewController.swift
//  SpinViewController
//
//  Created by user on 25/07/22.
//

import UIKit
let windowWidth = UIScreen.main.bounds.width
let windowHeight = UIScreen.main.bounds.height

class Spin2ViewController: UIViewController{

    //    let vc = LotteryItemView()
        var listItems = [LotteryItem]()

        var firstBlock : LotteryItemView!

        var secondBlock : LotteryItemView!

        var thirdBlock : LotteryItemView!

        var flag : Bool = false

        var id1 : Int!
        var id2 : Int!
        var id3 : Int!

        var label : UILabel!
        var price : Int = 0

        override func viewDidLoad() {
            super.viewDidLoad()
            let img = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
            img.image = UIImage(named: "wood")
            view.addSubview(img)
            self.initData()
            self.initViews()


        }

        private func initData(){
            self.listItems.append(LotteryItem(image: "1", id: 1))
            self.listItems.append(LotteryItem(image: "2", id: 2))
            self.listItems.append(LotteryItem(image: "3", id: 3))
            self.listItems.append(LotteryItem(image: "4", id: 4))
            self.listItems.append(LotteryItem(image: "5", id: 5))
            self.listItems.append(LotteryItem(image: "1", id: 6))
            self.listItems.append(LotteryItem(image: "2", id: 7))
            self.listItems.append(LotteryItem(image: "3", id: 8))
            self.listItems.append(LotteryItem(image: "4", id: 9))
            self.listItems.append(LotteryItem(image: "5", id: 10))
      }

        private func initViews(){
            label = UILabel(frame: CGRect(x: 30, y: 50, width: windowWidth - 60, height: 50))
            label.text = "Price: "
            label.textColor = .white
            label.backgroundColor = .magenta
            label.font = .boldSystemFont(ofSize: 30)

            self.view.addSubview(label)

            let top: CGFloat = windowWidth * 0.3
            let leftSpace: CGFloat = 25
            let spacing: CGFloat = 8
            let itemWidth: CGFloat = (windowWidth - (2*(leftSpace + spacing))) / 3

            self.firstBlock = LotteryItemView(frame: CGRect(x: leftSpace , y: top, width: itemWidth, height: itemWidth), list: self.listItems)

            self.view.addSubview(self.firstBlock)

            self.secondBlock = LotteryItemView(frame: CGRect(x: leftSpace + itemWidth + spacing, y: top, width: itemWidth, height: itemWidth), list: self.listItems)
            self.view.addSubview(self.secondBlock)

            self.thirdBlock = LotteryItemView(frame: CGRect(x: leftSpace + 2*(itemWidth + spacing), y: top, width: itemWidth, height: itemWidth), list: self.listItems)
            self.view.addSubview(self.thirdBlock)
    //        thirdBlock.conflikt

            let btn = UIButton(frame: CGRect(x: 130, y: thirdBlock.frame.maxY + 50, width: 100, height: 50))
            btn.setTitle("Play", for: .normal)
            btn.titleLabel?.font = .boldSystemFont(ofSize: 30)
            btn.setTitleColor(.black, for: .normal)
            btn.backgroundColor = .white
            btn.layer.cornerRadius = 10
            btn.addTarget(self, action: #selector(onPressRoller(_:)), for: .touchUpInside)
            view.addSubview(btn)

        }
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            self.navigationController?.setNavigationBarHidden(true, animated: true)



        }
        @objc func onPressRoller(_ sender: UIButton){
            self.flag = true
            self.firstBlock.roll()
            self.secondBlock.roll()
            self.thirdBlock.roll()
            thirdBlock.conflikt = {item in
                self.id3 = item.id
                print(self.id3)
            }
            firstBlock.conflikt = {item in
                self.id1 = item.id
                print(self.id1)
            }
            secondBlock.conflikt = {item in
                self.id2 = item.id
                print(self.id2)
            }
            if let bir = id1 , let ikki = id2 , let uch = id3{

                if id1 == id2 && id1 == id3 && flag == true {
                    print("yutdi")
                    self.alerfunc(bir:bir)
                    print(bir,ikki,uch)
                }else{
                    print("yutqazdi","=",bir,ikki,uch)
                 }

        }
    //        firstBlock



    }
        func alerfunc(bir:Int){
            let alert = UIAlertController(title: "🥳 🥳 🥳", message: "Marhamat mukofotni oling!", preferredStyle: .alert)
            alert.modalPresentationStyle = .fullScreen
            present(alert, animated: true)

            let okBtn = UIAlertAction(title: "OK", style: .default){action in
                    self.price +=  (bir*100)
                    self.label.text = "Price: \(self.price)"
            }
            alert.addAction(okBtn)
        }
    }
class LotteryItemView: UIView,UITableViewDelegate,UITableViewDataSource{
    private var list: [LotteryItem]
//    let vc = GameViewController()
    private var tableView : UITableView!
    var conflikt : ((LotteryItem) -> Void)?

    init(frame: CGRect, list: [LotteryItem]){
        self.list = list
        super.init(frame: frame)
        self.initViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func initViews(){
        self.layer.cornerRadius = 10
        self.backgroundColor = .clear

        self.tableView = UITableView(frame: CGRect(x: 5, y: 5, width: self.frame.width - 10, height: self.frame.height - 10))
        self.tableView.backgroundColor = .clear
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.separatorStyle = .none
        self.addSubview(tableView)
    }
    func roll(){
        self.list.shuffle()
                var nima = Int.random(in: self.list.count/2...self.list.count-1)
                conflikt?(list[nima])
                print(list[list.count - 2])
                self.tableView.reloadData()
        //        tableView

                UIView.animate(withDuration: 3.0, delay: 4.0, options: .curveEaseIn) {
                    self.tableView.scrollToRow(at: IndexPath(row: nima, section: 0), at: .top, animated: true)
                } completion: { done in

                }

    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = LotterTableViewCell(item: self.list[indexPath.row], size: CGSize(width: self.frame.width - 10, height: self.frame.height - 10))

        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.frame.width - 10
    }

}
class LotterTableViewCell: UITableViewCell{
    private var item : LotteryItem!
    init(item: LotteryItem,size : CGSize){
        self.item = item
        super.init(style: .default, reuseIdentifier: "LotterTableViewCell")
        self.initViews(size: size)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func initViews(size:CGSize){
        self.selectionStyle = .none
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .white

        let content : UIView = UIView(frame: CGRect(x: 2, y: 2, width: size.width - 4, height: size.height - 4))
        content.backgroundColor = .magenta
        content.layer.cornerRadius = 0

        let image = UIImageView(frame: CGRect(x: 5, y: 5, width: content.frame.width-10, height: content.frame.height-10))
        image.image = UIImage(named: self.item.image)
        image.clipsToBounds = true
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 5
        image.contentMode = .scaleToFill
        content.addSubview(image)
        self.contentView.addSubview(content)

    }
}

struct LotteryItem{
        var image: String
        var id: Int
}
