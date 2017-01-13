//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Alwin Lazar on 13/01/17.
//  Copyright © 2017 Xeoscript Technologies. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var outputLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var result = ""

    var currentOperation = Operation.Empty
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // to get the path of music file from the project.
        // Bundle is the bundle for the app that stores the actual files.
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        
        do {
            // first it check the below is correct if any fails it throws 
            // and that will catch the catch statement
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
            
        } catch let error as NSError {
            print(error.debugDescription)
            
        }
        
        // to set initial value to zero on screen
        outputLbl.text = "0"
    }
    
    @IBAction func numberPressed(sender: UIButton) {
        playSound()
        
        runningNumber += "\(sender.tag)"
        outputLbl.text = runningNumber
    }
    
    // Division
    @IBAction func onDividePressed(sender: AnyObject) {
        
        processOperation(operation: .Divide)
        
    }
    
    // Multiplication
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        
        processOperation(operation: .Multiply)
        
    }
    
    // Subtraction
    @IBAction func onSubtractPressed(sender: AnyObject) {
        
        processOperation(operation: .Subtract)
        
    }
    
    // Additon
    @IBAction func onAddPressed(sender: AnyObject) {
        
        processOperation(operation: .Add)
        
    }
    
    @IBAction func clearPressed(sender: AnyObject) {
        playSound()
        
        runningNumber = ""
        currentOperation = Operation.Empty
        
        outputLbl.text = "0"
    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(operation: currentOperation)
    }
    
    // if any sound is playing stop that first and replay that
    func playSound() {
        if btnSound.isPlaying {
            btnSound.stop()
        }
        
        btnSound.play()
    }
    
    func processOperation(operation: Operation) {
        playSound()
        
        if currentOperation != .Empty {
            
            
            if runningNumber != "" {
                
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == .Multiply {
                    
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                    
                } else if currentOperation == .Divide {
                    
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                    
                } else if currentOperation == .Subtract {
                    
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                    
                } else if currentOperation == .Add {
                    
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                    
                }
                
                
                leftValStr = result
                outputLbl.text = result
            }
            
            // A user select an operator, but then selected another operator
            // without first entering a number
            // so we set the operator is selected as second
            // 5 + - 2 we take 5 - 2 = 3.0
            currentOperation = operation
            
        } else {
            
            // this is the first time an operator has been pressed
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }


}

