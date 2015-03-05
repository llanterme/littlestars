import UIKit

class RegisterStudentVc: UIViewController,  UIAlertViewDelegate {
    

    var profileId: Int = 0

    @IBOutlet weak var studentName: UITextField!
    @IBOutlet weak var studentBirthday: UITextField!
    
    override func viewDidLoad() {
        
        println(profileId)
        super.viewDidLoad()


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }

    @IBAction func createStudent(sender: AnyObject) {
        
        ProgressView.shared.showProgressView(view)
        
        var uploadImageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("UploadImageSB") as UploadImageVc
        uploadImageViewController.profileId = self.profileId
        uploadImageViewController.name = studentName.text
        uploadImageViewController.birthday = studentBirthday.text
        
        self.presentViewController(uploadImageViewController, animated: true, completion: uploadControllerDismissed)
        
        
 
    }
    
    
    func uploadControllerDismissed() {
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }

    
    func createStudentDismissed() {
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    
    @IBAction func cancelStudentRegister(sender: AnyObject) {
        
          dismissViewControllerAnimated(true, completion: nil)
    }
}
