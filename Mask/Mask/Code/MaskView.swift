//
//  MaskView.swift
//  Mask
//
//  Created by wu on 2017/12/27.
//  Copyright © 2017年 wu. All rights reserved.
//

import UIKit

class MaskView: UIView {
    
    /// 蒙版颜色(非透明区颜色，默认黑色0.5透明度)
    var maskColor:UIColor = UIColor(white: 0, alpha: 0.5) {
        didSet{
            refrshMask()
        }
    }
    private lazy var fillLayer: CAShapeLayer = {
        let fl = CAShapeLayer()
        fl.frame = self.bounds
        self.layer.addSublayer(fl)
        return fl
    }()
    private lazy var overlayPath: UIBezierPath = {
        let op = UIBezierPath(rect: self.bounds)
        op.usesEvenOddFillRule = true
        return op
    }()
    /// 透明数组
    private var transparentPaths = [UIBezierPath]()
    /// 代码加载
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    /// 从xib加载
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        refrshMask()
    }
}
// MARK: - 初始化方法
extension MaskView{
    private func setupUI(){
        backgroundColor = UIColor.clear
//        maskColor = UIColor(white: 0, alpha: 0.5)
//        backgroundColor = maskColor
        fillLayer.path = overlayPath.cgPath
        fillLayer.fillRule = kCAFillRuleEvenOdd
        fillLayer.fillColor = maskColor.cgColor
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissMaskView))
        addGestureRecognizer(tap)
    }
}
// MARK: - 公开方法
extension MaskView{
    /// 添加有弧度矩形透明区
    ///
    /// - Parameters:
    ///   - rect: 位置
    ///   - radius: 弧度
    func add(rect:CGRect,radius:CGFloat){
        let path = UIBezierPath(roundedRect: rect, cornerRadius: radius)
        addTransparent(path: path)
    }
    
    /// 添加圆形透明区
    ///
    /// - Parameter ovalRect: 圆形位置
    func add(ovalRect:CGRect){
        let path = UIBezierPath(ovalIn: ovalRect)
        addTransparent(path: path)
    }
    
    /// 要显示的图片和位置
    ///
    /// - Parameters:
    ///   - image: 图片
    ///   - frame: 位置
    func add(image:UIImage, frame:CGRect){
        let imageView = UIImageView(frame: frame)
        imageView.backgroundColor = UIColor.clear
        imageView.image = image
        addSubview(imageView)
    }
    
    /// 在指定view上显示蒙版(过渡动画)
    ///
    /// - Parameter InView: 要显示在那个View上
    func showMaskView(view:UIView){
        self.alpha = 0
        view.addSubview(self)
        UIView.animate(withDuration: 0.3) {
            self.alpha = 1
        }
    }
    
    /// 销毁蒙版view(默认点击空白区自动销毁)
    @objc func dismissMaskView(){
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0
        }) { (_) in
            self.removeFromSuperview()
        }
    }
}
// MARK: - 私有方法
private extension MaskView{
    func refrshMask(){
        overlayPath = UIBezierPath(rect: bounds)
        overlayPath.usesEvenOddFillRule = true
        for path in transparentPaths{
            overlayPath.append(path)
        }
//        backgroundColor = maskColor
        fillLayer.frame = self.bounds
        fillLayer.path = overlayPath.cgPath
        fillLayer.fillColor = maskColor.cgColor
    }
    func addTransparent(path:UIBezierPath){
        overlayPath.append(path)
        transparentPaths.append(path)
        fillLayer.path = overlayPath.cgPath
    }
}
