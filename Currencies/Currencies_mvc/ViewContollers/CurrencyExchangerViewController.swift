//
//  CurrencyExchangerView.swift
//  Currencies_mvc
//
//  Created by Gökhan Gökoğlan on 2.08.2023.
//

import UIKit

class CurrencyExchangerViewController: UIViewController, UIPickerViewDelegate, UITextFieldDelegate, UIPickerViewDataSource {
    @IBOutlet weak var hesaplaButton: UIButton!
    @IBOutlet weak var changeTextfield: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    
    var changeInput: Int?
    var selectedOption: String = "Döviz Seçiniz"
    var exchangeResult: Float = 0
    var activeTextField: UITextField?
    
    let apiManager = APIManager.shared
    var currencies: [Currency]?
    
    let options = ["Döviz Seçiniz", "Dolar", "Euro", "Sterlin"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let doneButton = UIBarButtonItem(title: "Tamam", style: .done, target: self, action: #selector(doneButtonTapped))
        
        let doneToolBar = UIToolbar()
        doneToolBar.items = [doneButton]
        doneToolBar.sizeToFit()
        changeTextfield.inputAccessoryView = doneToolBar
        
        changeTextfield.delegate = self
        changeTextfield.keyboardType = .numberPad
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        fetchCurrencies()
    }
    
    func fetchCurrencies() {
           apiManager.fetchCurrencies { [weak self] currencies, error in
               guard let self = self else { return }

               if let error = error {
                   print("Error fetching currencies: \(error)")
                   return
               }
               self.currencies = currencies
               self.calculation()
           }
       }
        
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField == changeTextfield {
            if let input = textField.text, let number = Int(input) {
                changeInput = number
            } else {
                changeInput = nil
            }
        }
        return true
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return options.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return options[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            selectedOption = options[row]
            print("selected row: \(selectedOption)")
    }
    
    @objc func doneButtonTapped() {
        changeTextfield.resignFirstResponder()
    }
    
    @IBAction func exchange(_ sender: UIButton) {
        calculation()
        animate(sender)
    }
        
    func calculation() {
            guard let currencies = self.currencies else {
                resultLabel.text = "Currencies not available"
                return
            }

            if let changeInput = changeTextfield.text, let change = Float(changeInput) {
                var result: Float = 0

                switch selectedOption {
                case "Doviz Seciniz":
                    resultLabel.text = "Lütfen Çevirmek istediğiniz Bir Döviz Seçiniz"
                    
                case "Dolar":
                    let dolar = currencies[0].price
                    result = change * dolar
                    resultLabel.text = "₺\(result)"
                    currencyLabel.text = "Dolar = ₺\(dolar)"
                    
                case "Euro":
                    let euro = currencies[1].price
                    result = change * euro
                    resultLabel.text = "₺\(result)"
                    currencyLabel.text = "Euro = ₺\(euro)"
                    
                case "Sterlin":
                    let sterlin = currencies[2].price
                    result = change * sterlin
                    resultLabel.text = "₺\(result)"
                    currencyLabel.text = "Sterlin = ₺\(sterlin)"
                    
                default:
                    break
                }
            }
        }
    
    func animate(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: [], animations: {
            sender.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            }, completion: { (_) in
                UIView.animate(withDuration: 0.3) {
                    sender.transform = .identity
            }
        })
    }    
}
