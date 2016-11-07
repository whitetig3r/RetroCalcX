//
//  ViewController.swift
//  CalculatorX
//
//  Created by Warren White on 02/11/16.
//  Copyright © 2016 CalculatorX. All rights reserved.
//

import UIKit
import AVFoundation
import CoreMotion

class ViewController:UIViewController{
    override func canBecomeFirstResponder() -> Bool //to ensure that shake maybe first responder
    {
    return true
    }
    override func motionEnded(motion:UIEventSubtype, withEvent event: UIEvent?) // to provide shake to reset
      {
          if motion == .MotionShake {
            runningnumber = ""
            self.OutputLabel.text = "0.00"
            OperationProcess(Operators.Empty)
        }
      }
    
     enum Operators: String //enumeration to store operators
      {
          case Divide = "/"
          case Multiply = "*"
          case Add = "+"
          case Subtract = "-"
          case Empty = "Empty"
      }
    @IBOutlet weak var OutputLabel: UILabel! //output label
    var BtnSound :AVAudioPlayer! //for sound on press
    var runningnumber=""
    var rightsideno=""
    var leftsideno=""
    var currentoperation: Operators = Operators.Empty
    var result = ""
    @IBAction func ButtonPress(btn: UIButton!)
    {
        BtnSound.play()
        runningnumber += "\(btn.tag)"
        OutputLabel.text = runningnumber
    }
        override func viewDidLoad() {
        super.viewDidLoad()
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let SoundURL = NSURL (fileURLWithPath: path!)
        do{
            try BtnSound = AVAudioPlayer (contentsOfURL: SoundURL)
          } catch let err as NSError
          {
            print ("\(err)")
          }
         }
    

    @IBAction func OnDividePress(sender: AnyObject) {
        OperationProcess(Operators.Divide)
    }
   
    @IBAction func OnMultiplyPress(sender: AnyObject) {
        OperationProcess(Operators.Multiply)
    }

    @IBAction func OnAddPress(sender: AnyObject) {
        OperationProcess(Operators.Add)
    }
    @IBAction func OnSubtractPress(sender: AnyObject) {
        OperationProcess(Operators.Subtract)
    }
    @IBAction func OnEqualPress(sender: AnyObject) {
        OperationProcess(currentoperation)
    }
    func OperationProcess(op: Operators)
    {
        PlaySound()
        if currentoperation != Operators.Empty
        {
          if runningnumber != ""
         {
                
            rightsideno=runningnumber
            runningnumber=""
            if currentoperation == Operators.Multiply
            {
                result = "\(Float(rightsideno)! * Float(leftsideno)!)"
                
                
            }
            else if currentoperation == Operators.Divide
            {
                result = "\(Float(leftsideno)!/Float(rightsideno)!)"
                
            }
            else if currentoperation == Operators.Add
            {
                result = "\(Float(rightsideno)! + Float(leftsideno)!)"
            }
            else if currentoperation == Operators.Subtract
            {
                result = "\(Float(leftsideno)! - Float(rightsideno)!)"
            }

            leftsideno = result
            OutputLabel.text = result
            }
            currentoperation=op
        }
        else
        {
            leftsideno=runningnumber
            runningnumber=""
            currentoperation=op
        }
        
    }
    func PlaySound()
    {
        if BtnSound.playing
        {
            BtnSound.stop()
        }
        BtnSound.play()
    }
}

