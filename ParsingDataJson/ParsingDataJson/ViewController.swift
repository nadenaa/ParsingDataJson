//
//  ViewController.swift
//  ParsingDataJson
//
//  Created by yusronadena on 11/2/17.
//  Copyright © 2017 yusron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var useLabel: UILabel!
    @IBOutlet weak var labelCountry: UILabel!
    @IBOutlet weak var labelName: UILabel!
    var passName:String?
    var passCountry:String?
    var passUse:String?
    var passAmount:String?
    
    override func viewDidLoad() {
        
        labelName.text = "Your Username is " + passName!
        labelCountry.text = "Your Country is " + passCountry!
        useLabel.text = "Your Use is " + passUse!
        amountLabel.text = "Your Amount is " + passAmount!
        
        
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
