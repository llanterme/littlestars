

import UIKit

class RegisterStudentSessionVc: UIViewController, APIControllerProtocol {
    
    
     var api : APIController?
    @IBOutlet weak var profilePin: UITextField!

    override func viewDidLoad() {
        
         api = APIController(delegate: self)
        super.viewDidLoad()


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
 
    @IBAction func findStudents(sender: AnyObject) {
        
        
    }
    
    func didRecieveJson(results: NSDictionary) {
        
        
        let Students = results["Profile"]?["Students"] as NSArray
        
        
        
        ProgressView.shared.hideProgressView()
        
    }

}
