//
//  DisplayView.swift
//  A simple, animated bar to display a value.
//
//  Created by Nathan Gitter on 11/8/16.
//  Dedicated to all past, current, and future CSE 438 students.
//

import UIKit

/// A view for displaying a quantitative value. Set the `value` property to update the view.
/// To animate changes, call the `animateValue` method.
class DisplayView: UIView {
    
    /// The value to visually display. Valid range is between 0 and 1.
    public var value: CGFloat {
        get {
            return self.modelValue
        }
        set(newValue) {
            self.modelValue = newValue
            self.update(animated: false)
        }
    }
    
    /// The color of the display bar.
    public var color: UIColor = .black {
        didSet { self.valueView.backgroundColor = color }
    }
    
    private var modelValue: CGFloat = 0
    
    private let valueView = UIView()
    
    private var valueFrame: CGRect {
        var widthFraction = self.modelValue
        if widthFraction < 0 { widthFraction = 0 }
        if widthFraction > 1 { widthFraction = 1 }
        return CGRect(x: 0, y: 0, width: widthFraction * self.bounds.width, height: self.bounds.height)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    private func setup() {
        self.backgroundColor = UIColor(white: 0.9, alpha: 1)
        self.valueView.backgroundColor = color
        self.addSubview(self.valueView)
    }
    
    /// Animates the bar to the specified value. Valid range is between 0 and 1.
    public func animateValue(to newValue: CGFloat) {
        self.modelValue = newValue
        self.update(animated: true)
    }
    
    private func update(animated: Bool) {
        if animated {
            UIView.animate(withDuration: 0.5, animations: {
                self.valueView.frame = self.valueFrame
            })
        } else {
            self.valueView.frame = self.valueFrame
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.valueView.frame = self.valueFrame
    }
    
}