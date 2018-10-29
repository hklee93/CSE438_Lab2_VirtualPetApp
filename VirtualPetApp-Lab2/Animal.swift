//
//  Animal.swift
//  VirtualPetApp-Lab2
//
//  Created by Hakkyung on 2018. 9. 23..
//  Copyright © 2018년 Hakkyung Lee. All rights reserved.
//

import Foundation
import UIKit

class Animal{
    
    var name:Species
    var bgColor:UIColor
    var image:UIImage
    var happinessLevel:Int
    var foodLevel:Int
    var playCount:Int
    var fedCount:Int
    
    enum Species:String{
        
        case dog = "Dog"
        case cat = "Cat"
        case bird = "Bird"
        case bunny = "Bunny"
        case fish = "Fish"
    }
    
    func play(){
        
        
        if(foodLevel != 0){
            
            playCount += 1
            happinessLevel += 1
            foodLevel -= 1
            if(foodLevel < 0){
                
                foodLevel = 0
            }
        }
        if(foodLevel >= 10){
            
            foodLevel = 9
        }
    }
    
    func feed(){
        
        fedCount += 1
        if(foodLevel < 10){
            
            foodLevel += 1
        }
        else{
            
            foodLevel += 1
            happinessLevel -= 1
            if(foodLevel > 10 && happinessLevel > 10){
                
                foodLevel = 10
                happinessLevel = 9
            }
            
            if(happinessLevel < 0){
                
                happinessLevel = 0
            }
        }
    }
    
    init(name:Species, bgColor:UIColor, image:UIImage){
        
        self.name = name
        self.bgColor = bgColor
        self.image = image
        self.happinessLevel = 0
        self.foodLevel = 0
        self.playCount = 0
        self.fedCount = 0
    }
    
}
