//
//  KivaLoanTableViewController.swift
//  ParsingDataJson
//
//  Created by yusronadena on 11/1/17.
//  Copyright © 2017 yusron. All rights reserved.
//

import UIKit

class KivaLoanTableViewController: UITableViewController {
    
    let kivaloanURL = "https://api.kivaws.org/v1/loans/newest.json"
    var loans = [Loan]()
    
    var usernameSelected:String?
    var countrySelected:String?
    var useSelected:String?
    var amountSelected:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //mengambil dta dari api loans
        getLatestLoans()
        
        //self sizing cells
        //mengatur tinggi row table menjadi 92
        tableView.estimatedRowHeight = 92.0
        //mengatur tiggi row tanle menjadi doimensi otomatis
        tableView.rowHeight = UITableViewAutomaticDimension
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return loans.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as!
        KIvaLoanTAbleViewCell
        
        // Configure the cell...
        //memasukan nilainya kedalam masing masing label
        cell.nameLabel.text = loans[indexPath.row].name
        cell.countryLabel.text = loans[indexPath.row].country
        cell.useLabel.text = loans[indexPath.row].use
        cell.amoutLAbel.text = "$\(loans[indexPath.row].amount)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        //mengecek data yang dikirim
        let dataTask = loans[indexPath.row]
        //memasukan data ke variable namaSelected dan image selected ke masing masing variable nya
        usernameSelected = dataTask.name
        countrySelected = dataTask.country
        useSelected = dataTask.use
        amountSelected = "\(dataTask.amount)"
        //memamnggil segue passDataDetail
        performSegue(withIdentifier: "segue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //mengecek apakah segue nya ada atau  tidak
        if segue.identifier == "segue"{
            //kondisi ketika segue nya ada
            //mengirimkan data ke detailViewController
            let sendData = segue.destination as! ViewController
            sendData.passName = usernameSelected
            sendData.passCountry = countrySelected
            sendData.passUse = useSelected
            sendData.passAmount = amountSelected
        }
    }
  
    
    func getLatestLoans() {
        guard let loanURL = URL(string: kivaloanURL) else {
            return
        }
        
        let request = URLRequest(url: loanURL)
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response,error) -> Void in
            if let error = error {
            print(error)
            return
        }
            if let data = data {
            self.loans = self.parseJsonData(data: data)
            
                OperationQueue.main.addOperation({
                                                        self.tableView.reloadData()
                                                        
                                                    })
                                                }
        })
        task.resume()
    }
    
    func parseJsonData(data:Data) -> [Loan] {
        var loans = [Loan]()
        
        do {
            let jsonResult = try JSONSerialization.jsonObject(with: data, options:
                JSONSerialization.ReadingOptions.mutableContainers) as?
            NSDictionary
            
            
            let jsonLoans = jsonResult?["loans"] as! [AnyObject]
            
            for jsonLoan in jsonLoans {
                let loan = Loan()
                
                loan.name = jsonLoan["name"] as! String
                loan.amount = jsonLoan["loan_amount"] as! Int
                loan.use = jsonLoan["use"] as! String
                let location = jsonLoan["location"] as! [String:AnyObject]
                
                loan.country = location["country"] as! String
                loans.append(loan)
            }
            
        }catch{
            print(error)
        }
        return loans
    }
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
