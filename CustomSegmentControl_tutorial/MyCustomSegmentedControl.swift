//
//  MyCustomSegmentedControl.swift
//  CustomSegmentControl_tutorial
//
//  Created by 김동환 on 2021/04/22.
//

import Foundation
import UIKit

protocol MyCustomSegmentControlDelegate:class {
    // 아이템이 선정됨
    func segmentValueChanged(to index: Int)
}

class MyCustomSegmentedControl: UIView {
    private var buttonTitles: [String]!
    private var buttons: [UIButton]!
    var textColor: UIColor = .black
    var selectedColor: UIColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
    
    public private(set) var selectedIndex: Int = 0
    
    weak var mySegmentedDelegate: MyCustomSegmentControlDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //기본적인 뷰 설정
    }
    //데이터를 뷰에 적용할 때
    convenience init(frame: CGRect, buttonTitles: [String]){
        self.init(frame: frame)
        self.buttonTitles = buttonTitles
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        updateView()
    }
    
    fileprivate func updateView(){
        //버튼 만들기
        createBtn()
        //스택뷰 설정하기
        configStackView()
    }
    
    fileprivate func createBtn(){
        self.buttons = [UIButton]()
        
        //기존 버튼들 다 지우기
        self.buttons.removeAll()
        
        //하위 뷰들을 다 지운다.
        self.subviews.forEach({$0.removeFromSuperview()})
        for buttonTitleItem in buttonTitles {
            let button = UIButton(type: .system)
            button.backgroundColor = .white
            button.titleLabel?.textColor = .black
            button.layer.borderWidth = 1
            button.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            button.backgroundColor = .white
            button.layer.cornerRadius = 20
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
            button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            button.titleLabel?.adjustsFontSizeToFitWidth = true
            button.titleLabel?.minimumScaleFactor = 0.5 
            button.setTitle(buttonTitleItem, for: .normal)
            button.setTitleColor(textColor, for: .normal)
            button.addTarget(self, action: #selector(MyCustomSegmentedControl.buttonAction(_:)), for: .touchUpInside)
            self.buttons.append(button)
        }
        
        buttons[0].setTitleColor(.white, for: .normal)
        buttons[0].backgroundColor = selectedColor
    }
    
    fileprivate func configStackView(){
        
        let stackView = UIStackView(arrangedSubviews: buttons)
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        self.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    @objc func buttonAction(_ sender: UIButton) {
        
        for (buttonIndex, btn) in buttons.enumerated() {
            btn.setTitleColor(textColor, for: .normal)
            if btn == sender {
                self.selectedIndex = buttonIndex
                mySegmentedDelegate?.segmentValueChanged(to: self.selectedIndex)
                btn.backgroundColor = selectedColor
                btn.setTitleColor(.white, for: .normal)
            } else {
                btn.backgroundColor = .white
                btn.setTitleColor(.black, for: .normal)
            }
        }
    }
    
}


#if DEBUG
import SwiftUI

struct ViewControllerRepresentable: UIViewControllerRepresentable {
func updateUIViewController(_ uiViewController: UIViewController,context: Context) {
        // leave this empty
}
@available(iOS 13.0.0, *)
func makeUIViewController(context: Context) -> UIViewController {
        ViewController()
    }
}
@available(iOS 13.0, *)
struct MyTestViewControllerPreviewProvider: PreviewProvider {
    static var previews: some View {
        Group {
            ViewControllerRepresentable()
                .previewDisplayName(/*@START_MENU_TOKEN@*/"Preview"/*@END_MENU_TOKEN@*/)
                .previewDevice(PreviewDevice(rawValue: "iPhone 11"))

        }
        
    }
} #endif
