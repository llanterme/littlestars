

import UIKit

class SearchProfileVc: UIViewController , APIControllerProtocol  {
    
    var api : APIController?
    var profileId: Int = 0
    
    
    @IBOutlet weak var profilePin: UITextField!
    @IBOutlet weak var searchResultsView: UIView!
    @IBOutlet weak var profileResults: UIView!
    @IBOutlet weak var profileResultName: UITextField!
    @IBOutlet weak var profileResultSurname: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        api = APIController(delegate: self)

     
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    @IBAction func searchProfile(sender: AnyObject) {
        
          ProgressView.shared.showProgressView(view)
        
        api!.GetProfileOverview(self.profilePin.text)

    
    }
    
 func didRecieveJson(results: NSDictionary) {
    
     var resultsArr: NSArray = results[0] as? NSArray ?? []

      self.profileResultName.text = results["Profile"]?["Name"] as String
      profileResultName.layer.borderWidth = 1.0
      profileResultName.layer.borderColor = UIColor.lightGrayColor().CGColor
    
      self.profileResultSurname.text = results["Profile"]?["Surname"] as String
      profileResultSurname.layer.borderWidth = 1.0
      profileResultSurname.layer.borderColor = UIColor.lightGrayColor().CGColor
    
     profileId = results["Profile"]?["ProfileId"] as Int
    println(profileId)
    
     self.profileResults.hidden = false
    
      ProgressView.shared.hideProgressView()

 }
    
    
    @IBAction func AddStudent(sender: AnyObject) {
        
        var registerStudent = self.storyboard?.instantiateViewControllerWithIdentifier("RegisterStudentSB") as RegisterStudentVc
        registerStudent.profileId = self.profileId
        self.presentViewController(registerStudent, animated: true, completion: createStudentDismissed)
        
        
    }

    func createStudentDismissed() {
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
   
}
