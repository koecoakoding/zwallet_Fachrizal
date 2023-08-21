//
//  CustomView.swift
//  Zwallet-new
//
//  Created by Randy Senjaya on 15/08/23.
//

import UIKit

@IBDesignable


class customView: UIView{
    @IBInspectable
    var cornerRadius: CGFloat = 0{
        didSet{
            update()
        }
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        update()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        update()
    }
    
    func update(){
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
        layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
}
