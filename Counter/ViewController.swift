//
//  ViewController.swift
//  Counter
//
//  Created by Nurbol on 20.05.2024.
//

import UIKit

class ViewController: UIViewController {
    
    private let incrementButtonTag = 1
    private let decrementButtonTag = 2
    private let resetButtonTag = 3
    private var counter: Int = 0 {
        didSet {
            counterLabel.text = "Значение счётчика: \(counter)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var decrementButton: UIButton!
    @IBOutlet weak var incrementButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var changeHistoryTextView: UITextView!
    
    private func updateUI() {
        
        changeHistoryTextView.text = "История изменений:\n"
        incrementButton.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        decrementButton.setImage(UIImage(systemName: "minus.circle.fill"), for: .normal)
        resetButton.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
        incrementButton.tag = incrementButtonTag
        decrementButton.tag = decrementButtonTag
        resetButton.tag = resetButtonTag
        
    }
    
    private func changeState(button: UIButton) {
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "[dd.MM.yyyy HH:mm:ss]"
        let dateString = formatter.string(from: date)
        
        switch button.tag {
        case incrementButtonTag:
            counter += 1
            changeHistoryTextView.append("\(dateString):\nзначение изменено на +1\n")
        case decrementButtonTag:
            counter -= 1
            if counter >= 0 {
                changeHistoryTextView.append("\(dateString):\nзначение изменено на -1\n")
            } else {
                counter = 0
                changeHistoryTextView.append("\(dateString):\nпопытка уменьшить значение счётчика ниже 0\n")
            }
        case resetButtonTag:
            changeHistoryTextView.append("\(dateString):" + " значение сброшено\n")
        default :
            changeHistoryTextView.append("\(dateString):\nпопытка уменьшить значение счётчика ниже 0\n")
        }
    }
    
    @IBAction func resetButtonTap(_ sender: UIButton) {
        counter = 0
        counterLabel.text = "Значение счётчика: \(counter)"
        changeState(button: sender)
    }
    
    @IBAction func counterButtonTap(_ sender: UIButton) {
        changeState(button: sender)
    }
}

extension UITextView {
    func append(_ string : String) {
        let endOfDocument = self.endOfDocument
        if let atEnd = self.textRange(from: endOfDocument, to: endOfDocument) {
            self.replace(atEnd, withText: string)
        }
    }
}
