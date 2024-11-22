//
//  ViewController.swift
//  SparkSupportMachineTest
//
//  Created by Salman Macbook Air M3 on 22/11/24.
//

import UIKit

class LandingVC: UIViewController {

    @IBOutlet weak var latitudeTxtFld: UITextField!
    @IBOutlet weak var longitudeTxtFld: UITextField!
    @IBOutlet weak var fetchWthrBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchWthrBtn.layer.cornerRadius = 10
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    @IBAction func fetchWeathrBtnTapped(_ sender: UIButton) {
        
        guard let latitudeText = latitudeTxtFld.text, let latitude = Double(latitudeText),
        let longitudeText = longitudeTxtFld.text, let longitude = Double(longitudeText) else {
        showAlert(message: "Please enter valid latitude and longitude.")
        return
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = storyboard.instantiateViewController(identifier: "ResultVC") as! ResultVC
        nextVC.latitude = latitude
        nextVC.longitude = longitude
        navigationController?.pushViewController(nextVC, animated: false)
                 
    }
    
    
    private func showAlert(message: String) {
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    
}

