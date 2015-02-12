
import UIKit

class RegisterProfileVc: UIViewController, APIControllerProtocol,UIAlertViewDelegate {
    
    var api : APIController?
    var profileId: Int = 0
    
    
    @IBOutlet weak var profileEmail: UITextField!
    @IBOutlet weak var profileName: UITextField!
    @IBOutlet weak var profileCell: UITextField!
    @IBOutlet weak var profileSurname: UITextField!
    
    override func viewDidLoad() {
        
        api = APIController(delegate: self)
        super.viewDidLoad()

   
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
   
    }
    
    
    func didRecieveJson(results: NSDictionary) {
        
        ProgressView.shared.hideProgressView()
        
        var newProfileId = results["Message"] as String
        var message = results["Status"] as? String
        
        var createProfileResponse : [String] = newProfileId.componentsSeparatedByString("|")

        
        if message == "success" {
            
            profileId = createProfileResponse[0].toInt()!
            
            let alert = UIAlertView()
            alert.delegate = self
            alert.title = "Alert"
            alert.message = "Parent profile created. Your pin is" + " " + createProfileResponse[1] +  " " + " Add child?"
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
    
   
    
    @IBAction func cancelRegistration(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func registerProfile(sender: AnyObject) {
        ProgressView.shared.showProgressView(view)
        
        var newProfile = ProfileModel(surname: profileSurname.text, name: profileName.text, cell: profileCell.text, email: profileEmail.text)
        
        api!.CreateProfile(newProfile)
    }
    
    func alertView(View: UIAlertView!, clickedButtonAtIndex buttonIndex: Int){
        
        switch buttonIndex{
            
        case 0:
           
            var registerStudent = self.storyboard?.instantiateViewControllerWithIdentifier("RegisterStudentSB") as RegisterStudentVc
            registerStudent.profileId = self.profileId
            self.presentViewController(registerStudent, animated: true, completion: createStudentDismissed)
            
        break;
        case 1:
            println("Dismiss");
            break;
        default:
            println("Default");
            break;

            
        }
    }
    
    func createStudentDismissed() {
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    

}
