//
//  LaunchScreen.swift
//  SparkSupportMachineTest
//
//  Created by Salman Macbook Air M3 on 22/11/24.
//

import UIKit

class LaunchScreenVC: UIViewController {

    @IBOutlet weak var aboutBtn: UIButton!
    @IBOutlet weak var getStrtBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        aboutBtn.layer.cornerRadius = 10
        getStrtBtn.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
    }
    
    @IBAction func aboutBtnTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = storyboard.instantiateViewController(withIdentifier: "AboutVC") as! AboutVC
        self.navigationController?.pushViewController(nextVC, animated: false)
    }
    
    @IBAction func getStartBtnTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = storyboard.instantiateViewController(withIdentifier: "LandingVC") as! LandingVC
        self.navigationController?.pushViewController(nextVC, animated: false)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
