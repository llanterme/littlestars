

import UIKit

class CreateSessionVc: UIViewController, APIControllerProtocol, UIAlertViewDelegate {
    
     var api : APIController?
    
    @IBOutlet weak var createSessionAlias: UITextField!
    
    @IBOutlet weak var createSessionDuration: UITextField!

    @IBOutlet weak var createSessionStartDate: UITextField!
    
    @IBOutlet weak var createSessionStartTime: UITextField!
    
    override func viewDidLoad() {
        
        api = APIController(delegate: self)
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    


    @IBAction func createSession(sender: AnyObject) {
        
         ProgressView.shared.showProgressView(view)
        api?.CreateSession(createSessionAlias.text, startDate: createSessionStartDate.text, startTime: createSessionStartTime.text, duration: createSessionDuration.text)
    }
    
    
    func didRecieveJson(results: NSDictionary) {
        
        ProgressView.shared.hideProgressView()
        
        var message = results["Status"] as? String
        
        if message == "success" {
            
            let alert = UIAlertView()
            alert.delegate = self
            alert.title = "Alert"
            alert.message = "Session created!"
            alert.addButtonWithTitle("Yes")
            alert.addButtonWithTitle("No")
            alert.show()
            
            
        }
        
    }
    
    func didRecieveError(error: NSError) {
        
        ProgressView.shared.hideProgressView()
        
        let alert = UIAlertView()
        alert.title = "Alert"
        alert.message = "An error has occured! Try again!"
        alert.addButtonWithTitle("Ok")
        alert.show()
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    func alertView(View: UIAlertView!, clickedButtonAtIndex buttonIndex: Int){
        
        switch buttonIndex{
            
        case 0:
            
            createSessionDismissed()
            
            break;
        case 1:
            println("Dismiss");
            break;
        default:
            println("Default");
            break;
            
            
        }
    }
    
    func createSessionDismissed() {
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }

}
