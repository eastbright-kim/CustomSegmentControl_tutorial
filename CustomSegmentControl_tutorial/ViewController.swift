//
//  ViewController.swift
//  CustomSegmentControl_tutorial
//
//  Created by 김동환 on 2021/04/22.
//

import UIKit

class ViewController: UIViewController, MyCustomSegmentControlDelegate {
    
    var myDayArray = ["월", "화", "수", "목", "금"]
    var myDayCharArray = ["🐶","🐱","🐭", "🐹", "🦊"]
    
    @IBOutlet weak var whatDayTitle: UILabel!
    
    func segmentValueChanged(to index: Int) {
        print("view controller - segmentValueChanged \(index)")
        self.whatDayTitle.text = myDayArray[index] + "요일\n" + myDayCharArray[index]
    }
    

    
    override func loadView() {
        super.loadView()
        let myCustomSegmentControl = MyCustomSegmentedControl(frame: CGRect(x: 0, y: 0, width: 200, height: 200), buttonTitles: myDayArray)
        myCustomSegmentControl.mySegmentedDelegate = self
        self.view.addSubview(myCustomSegmentControl)
//        myCustomSegmentControl.backgroundColor = .red
        myCustomSegmentControl.translatesAutoresizingMaskIntoConstraints = false
        myCustomSegmentControl.widthAnchor.constraint(equalToConstant: 300).isActive = true
        myCustomSegmentControl.heightAnchor.constraint(equalToConstant: 60).isActive = true
        myCustomSegmentControl.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        myCustomSegmentControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

