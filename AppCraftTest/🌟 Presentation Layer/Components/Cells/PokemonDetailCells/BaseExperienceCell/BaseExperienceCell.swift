//
//  BaseExperienceCell.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 01.03.2021.
//

import GKRepresentable

class BaseExperienceCell: TableCell {
    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var expLabel: UILabel!
    
    var shapeLayer = CAShapeLayer()
    
    override func setupView() {
        self.titleLabel.text = AppLocalization.PokemonDetails.base_experience.localized
        setupCircleView()
        self.expLabel.apply(.headerTitleStyle())
        self.titleLabel.apply(.header2TitleStyle())
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        return
    }
    
    override func updateViews() {
        guard let model = self.model as? BaseExperienceCellModel else { return }
        expLabel.text = String(model.baseExp)
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = Double(model.baseExp) / 700
        animation.duration = 1
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        shapeLayer.add(animation, forKey: "filling")
    }
    
    private func setupCircleView() {
        let lowerLayer = CAShapeLayer()
        
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: circleView.frame.width / 2, y: circleView.frame.height / 2), radius: 60, startAngle: -CGFloat.pi / 2, endAngle: 2*CGFloat.pi, clockwise: true)
        
        lowerLayer.path = circularPath.cgPath
        lowerLayer.strokeColor = UIColor.lightGray.cgColor
        lowerLayer.lineWidth = 8
        lowerLayer.fillColor = UIColor.clear.cgColor
        circleView.layer.addSublayer(lowerLayer)
        
        
        shapeLayer.path = circularPath.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        
        shapeLayer.strokeColor = UIColor.green.cgColor
        shapeLayer.strokeEnd = 0
        shapeLayer.lineWidth = 10
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        
        self.circleView.layer.addSublayer(shapeLayer)
    }
}
