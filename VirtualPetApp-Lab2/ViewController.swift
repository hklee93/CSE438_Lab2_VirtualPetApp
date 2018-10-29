//
//  ViewController.swift
//  VirtualPetApp-Lab2
//
//  Created by Hakkyung on 2018. 9. 20..
//  Copyright © 2018년 Hakkyung Lee. All rights reserved.
//
//  Updating DisplayView is from the lecture
//  Sound files are from https://www.salamisound.com/
//  Playing sound reference: https://stackoverflow.com/questions/25736470/swift-how-to-play-sound-when-press-a-button
//  Multiple animation reference: https://stackoverflow.com/questions/41797844/swift-ios-multiple-successive-multiple-animations-with-same-uiview
//
//


import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var animalView: UIImageView!
    @IBOutlet weak var backGroundView: UIView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var feedButton: UIButton!
    @IBOutlet weak var happinessLevel: UILabel!
    @IBOutlet weak var foodLevel: UILabel!
    @IBOutlet weak var happinessBar: DisplayView!
    @IBOutlet weak var foodLevelBar: DisplayView!
    @IBOutlet weak var dogButton: UIButton!
    @IBOutlet weak var catButton: UIButton!
    @IBOutlet weak var birdButton: UIButton!
    @IBOutlet weak var bunnyButton: UIButton!
    @IBOutlet weak var fishButton: UIButton!
    
    private var currentAnimal:Animal!
    var myDog:Animal!
    var myCat:Animal!
    var myBird:Animal!
    var myBunny:Animal!
    var myFish:Animal!
    
    var dogSound = Bundle.main.path(forResource: "dog", ofType: ".mp3")
    var catSound = Bundle.main.path(forResource: "cat", ofType: ".mp3")
    var birdSound = Bundle.main.path(forResource: "bird", ofType: ".mp3")
    var bunnySound = Bundle.main.path(forResource: "bell", ofType: ".mp3")
    var fishSound = Bundle.main.path(forResource: "water", ofType: ".mp3")
    var jumpSound = Bundle.main.path(forResource: "jump", ofType: ".mp3")
    
    var audioPlayer:AVAudioPlayer = AVAudioPlayer()
    var audioPlayerJump:AVAudioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        myDog = Animal(name: .dog, bgColor: UIColor.red, image: UIImage(named: "dog")!)
        myCat = Animal(name: .cat, bgColor: UIColor.blue, image: UIImage(named: "cat")!)
        myBird = Animal(name: .bird, bgColor: UIColor.yellow, image: UIImage(named: "bird")!)
        myBunny = Animal(name: .bunny, bgColor: UIColor.green, image: UIImage(named: "bunny")!)
        myFish = Animal(name: .fish, bgColor: UIColor.purple, image: UIImage(named: "fish")!)
        
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: URL(fileURLWithPath: dogSound!))
            try audioPlayerJump = AVAudioPlayer(contentsOf: URL(fileURLWithPath: jumpSound!))
        }
        catch{
            print(error)
        }
        
        currentAnimal = myDog
        currentAnimalSet()
    }
    @IBAction func playPressed(_ sender: Any) {
        
        currentAnimal.play()
        if(currentAnimal.foodLevel != 0){
        
            audioPlayer.play()
        }
        
        if(currentAnimal.foodLevel == 0){
            
            //not sure how to handle repeating motion yet. Tried .repeat for options parameter, but the motion seemed to be glitch
            UIView.animate(withDuration: 0.2, animations:{
            
                self.animalView.frame.origin.x -= 20
            }, completion:{(value: Bool) in
                
                UIView.animate(withDuration: 0.2, animations:{
                    
                    self.animalView.frame.origin.x += 40
                }, completion:{(value: Bool) in
                    
                    UIView.animate(withDuration: 0.2, animations:{
                        
                        self.animalView.frame.origin.x -= 40
                    }, completion:{(value: Bool) in
                        
                        UIView.animate(withDuration: 0.2, animations:{
                            
                            self.animalView.frame.origin.x += 20
                        })
                    })
                })
            })
        }
        updateDisplay()
    }
    @IBAction func feedPressed(_ sender: Any) {
        
        currentAnimal.feed()
        audioPlayer.play()
        if(currentAnimal.foodLevel == 10){
            
            audioPlayerJump.play()
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1.0, animations: {
                
                self.animalView.frame.origin.y -= 80
            }, completion: { (value: Bool) in
                UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, animations: {
                    
                    self.animalView.frame.origin.y += 80
                })
            })
        }
        
        updateDisplay()
    }
    @IBAction func changeAnimal(_ sender: UIButton!) {
        
        let chosen:String = sender.currentTitle!
        let myEnum = Animal.Species(rawValue: chosen)
        
        switch myEnum!{

        case .dog:
            currentAnimal = myDog
            do {
                try audioPlayer = AVAudioPlayer(contentsOf: URL(fileURLWithPath: dogSound!))
            }
            catch{
                print(error)
            }
        case .cat:
            currentAnimal = myCat
            do {
                try audioPlayer = AVAudioPlayer(contentsOf: URL(fileURLWithPath: catSound!))
            }
            catch{
                print(error)
            }
        case .bird:
            currentAnimal = myBird
            do {
                try audioPlayer = AVAudioPlayer(contentsOf: URL(fileURLWithPath: birdSound!))
            }
            catch{
                print(error)
            }
        case .bunny:
            currentAnimal = myBunny
            do {
                try audioPlayer = AVAudioPlayer(contentsOf: URL(fileURLWithPath: bunnySound!))
            }
            catch{
                print(error)
            }
        case .fish:
            currentAnimal = myFish
            do {
                try audioPlayer = AVAudioPlayer(contentsOf: URL(fileURLWithPath: fishSound!))
            }
            catch{
                print(error)
            }
        }
        
        currentAnimalSet()
    }
    
    func currentAnimalSet(){
        
        happinessBar.color = currentAnimal.bgColor
        foodLevelBar.color = currentAnimal.bgColor
        backGroundView.backgroundColor = currentAnimal.bgColor
        animalView.image = currentAnimal.image
        updateDisplay()
    }
    
    func updateDisplay(){
 
        let happinessBarValue = Double(currentAnimal.happinessLevel) / 10
        let foodLevelBarValue = Double(currentAnimal.foodLevel) / 10
        
        happinessBar.animateValue(to: CGFloat(happinessBarValue))
        happinessLevel.text = "Played: " + String(currentAnimal.playCount)
        
        foodLevelBar.animateValue(to: CGFloat(foodLevelBarValue))
        foodLevel.text = "Fed: " + String(currentAnimal.fedCount)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
}

