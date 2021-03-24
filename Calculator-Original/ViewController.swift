//
//  ViewController.swift
//  Calculator-Original
//
//  Created by Toshiyana on 2021/03/25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var holder: UIView!
    
    var firstNumber = 0
    var resultNumber = 0
    var currentOperation: Operation?
    
    enum Operation {
        case add, subtract, multiply, divide
    }
    
    private var resultLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .white
        label.textAlignment = .right
        label.font = UIFont(name: "Helevetica", size: 100)
        label.font = label.font.withSize(100)//UIFont(size)だけだとなぜかサイズ変わらない
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupNumberPad()
    }

    private func setupNumberPad() {
        let buttonSize: CGFloat = view.frame.size.width / 4.0

        let zeroButton = UIButton(frame: CGRect(x: 0, y: holder.frame.size.height-buttonSize, width: buttonSize*3, height: buttonSize))
        zeroButton.setTitle("0", for: .normal)
        zeroButton.setTitleColor(.white, for: .normal)
        zeroButton.backgroundColor = .blue
        zeroButton.tag = 1
        holder.addSubview(zeroButton)
        zeroButton.addTarget(self, action: #selector(zeroButtonPressed(_:)), for: .touchUpInside)
        
        for numOfButton in 0..<3 {
            let button1 = UIButton(frame: CGRect(x: buttonSize*CGFloat(numOfButton), y: holder.frame.size.height-(buttonSize*2), width: buttonSize, height: buttonSize))
            button1.setTitle("\(numOfButton+1)", for: .normal)
            button1.setTitleColor(.white, for: .normal)
            button1.backgroundColor = .blue
            button1.tag = numOfButton + 2
            holder.addSubview(button1)
            button1.addTarget(self, action: #selector(numButtonPressed(_:)), for: .touchUpInside)
        }
        
        for numOfButton in 0..<3 {
            let button2 = UIButton(frame: CGRect(x: buttonSize*CGFloat(numOfButton), y: holder.frame.size.height-(buttonSize*3), width: buttonSize, height: buttonSize))
            button2.setTitle("\(numOfButton+4)", for: .normal)
            button2.setTitleColor(.white, for: .normal)
            button2.backgroundColor = .blue
            button2.tag = numOfButton + 5
            holder.addSubview(button2)
            button2.addTarget(self, action: #selector(numButtonPressed(_:)), for: .touchUpInside)
        }

        for numOfButton in 0..<3 {
            let button3 = UIButton(frame: CGRect(x: buttonSize*CGFloat(numOfButton), y: holder.frame.size.height-(buttonSize*4), width: buttonSize, height: buttonSize))
            button3.setTitle("\(numOfButton+7)", for: .normal)
            button3.setTitleColor(.white, for: .normal)
            button3.backgroundColor = .blue
            button3.tag = numOfButton + 8
            holder.addSubview(button3)
            button3.addTarget(self, action: #selector(numButtonPressed(_:)), for: .touchUpInside)
        }

        let operations1 = ["AC", "+/-", "%"]
        for numOfButton in 0..<3 {
            let button4 = UIButton(frame: CGRect(x: buttonSize*CGFloat(numOfButton), y: holder.frame.size.height-(buttonSize*5), width: buttonSize, height: buttonSize))
            button4.setTitle("\(operations1[numOfButton])", for: .normal)
            button4.setTitleColor(.white, for: .normal)
            button4.backgroundColor = .gray
            holder.addSubview(button4)
            
            if operations1[numOfButton] == "AC" {
                button4.addTarget(self, action: #selector(acButtonPressed(_:)), for: .touchUpInside)
            }
        }
        
        let operations2 = ["=", "+", "-", "x", "/"]
        for numOfButton in 0..<5 {
            let button5 = UIButton(frame: CGRect(x: buttonSize*3, y: holder.frame.size.height-(buttonSize*CGFloat(numOfButton+1)), width: buttonSize, height: buttonSize))
            button5.setTitle("\(operations2[numOfButton])", for: .normal)
            button5.setTitleColor(.white, for: .normal)
            button5.backgroundColor = .orange
            button5.tag = numOfButton + 1
            holder.addSubview(button5)
            button5.addTarget(self, action: #selector(operationButtonPressed(_:)), for: .touchUpInside)
        }

        resultLabel.frame = CGRect(x: 20, y: holder.frame.size.height-(buttonSize*6), width: view.frame.size.width-40, height: 100)
        holder.addSubview(resultLabel)
    }
    
    @objc func acButtonPressed(_ sender: UIButton) {
        resultLabel.text = "0"
        currentOperation = nil
        firstNumber = 0
    }
    
    @objc func zeroButtonPressed(_ sender: UIButton) {
        
        if resultLabel.text != "0" {
            if let text = resultLabel.text {
                resultLabel.text = "\(text)\(0)"
            }
        }
        
    }
    
    @objc func numButtonPressed(_ sender: UIButton) {
        let tag = sender.tag - 1
        
        if resultLabel.text == "0" {
            resultLabel.text = "\(tag)"
        } else if let text = resultLabel.text {
            resultLabel.text = "\(text)\(tag)"
        }
    }
    
    @objc func operationButtonPressed(_ sender: UIButton) {
        let tag = sender.tag
        
        if let text = resultLabel.text, let value = Int(text), firstNumber == 0 {
            firstNumber = value
            resultLabel.text = "0"
        }
        
        if tag == 1 {
            if let operation = currentOperation {
                var secondNumber = 0
                if let text = resultLabel.text, let value = Int(text) {
                    secondNumber = value
                }
                
                switch operation {
                
                case Operation.add:
                    let result = firstNumber + secondNumber
                    resultLabel.text = "\(result)"
                    break
                
                case Operation.subtract:
                    let result = firstNumber - secondNumber
                    resultLabel.text = "\(result)"
                    break
                
                case Operation.multiply:
                    let result = firstNumber * secondNumber
                    resultLabel.text = "\(result)"
                    break

                case Operation.divide:
                    let result = firstNumber / secondNumber
                    resultLabel.text = "\(result)"
                    break
                }
            

            }
        }
        else if tag == 2 {
            currentOperation = Operation.add
        }
        else if tag == 3 {
            currentOperation = Operation.subtract
        }
        else if tag == 4 {
            currentOperation = Operation.multiply
        }
        else if tag == 5 {
            currentOperation = Operation.divide
        }
    }
}

