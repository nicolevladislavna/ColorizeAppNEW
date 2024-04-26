//
//  ViewController.swift
//  ColorizeApp
//
//  Created by Veronika Iskandarova on 26.04.2024.
//

import UIKit

protocol SettingsViewControllerDelegate: AnyObject {
    func settingsViewController(_ controller: SettingsViewController, didSelectedColor: UIColor)
}

final class SettingsViewController: UIViewController {
    
    @IBOutlet var colorView: UIView!
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    weak var delegate: SettingsViewControllerDelegate!
    var currentColor: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationItem.hidesBackButton = true
        colorView.layer.cornerRadius = 20
        
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
        
        if let color = currentColor {
            setColor(color)
        }
        updateColor()
    }
    
    @IBAction func colorizedRed() {
        redTextField.text = "\(round(redSlider.value * 100) / 100)"
        updateColor()
    }
    
    @IBAction func colorizedGreen() {
        greenTextField.text = "\(round(greenSlider.value * 100) / 100)"
        updateColor()
    }
    
    @IBAction func colorizedBlue() {
        blueTextField.text = "\(round(blueSlider.value * 100) / 100)"
        updateColor()
    }
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        let selectedColor = colorView.backgroundColor ?? UIColor.white
        delegate?.settingsViewController(self, didSelectedColor: selectedColor)
        dismiss(animated: true)
    }
    
    private func setColor(_ color: UIColor) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        redSlider.value = Float(red)
        greenSlider.value = Float(green)
        blueSlider.value = Float(blue)
        
        updateColor()
    }
    
    private func updateColor() {
        let red = CGFloat(redSlider.value)
        let green = CGFloat(greenSlider.value)
        let blue = CGFloat(blueSlider.value)
        
        colorView.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        
        redTextField.text = String(format: "%.2f", redSlider.value)
        greenTextField.text = String(format: "%.2f", greenSlider.value)
        blueTextField.text = String(format: "%.2f", blueSlider.value)
    }
    
    // MARK: ShowValidationError
    
    private func showValidationError() {
        let alert = UIAlertController(title: "Ошибка", message: "Введите значение от 0 до 1", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: UITextFieldDeligate

extension SettingsViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text, let value = Float(text), value >= 0, value <= 1 {
            switch textField {
            case redTextField:
                redSlider.value = value
            case greenTextField:
                greenSlider.value = value
            case blueTextField:
                blueSlider.value = value
            default:
                break
            }
            updateColor()
        } else {
            showValidationError()
            switch textField {
            case redTextField:
                textField.text = String(format: "%.2f", redSlider.value)
            case greenTextField:
                textField.text = String(format: "%.2f", greenSlider.value)
            case blueTextField:
                textField.text = String(format: "%.2f", blueSlider.value)
            default:
                break
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
