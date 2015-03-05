

import UIKit

class UploadImageVc: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, APIControllerProtocol, UIAlertViewDelegate  {
    
     var api : APIController?
     var profileId: Int = 0
     var name: String = ""
     var birthday: String = ""

    @IBOutlet weak var imagePreview: UIImageView!
    @IBOutlet weak var imageUploadButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

         api = APIController(delegate: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    @IBAction func uploadImageAction(sender: AnyObject) {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary){
            
            var image = UIImagePickerController()
            image.delegate = self
            image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
            image.allowsEditing = false
            
            self.presentViewController(image, animated: true, completion: nil)
        }
        
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!) {
        
        if (image != nil) {
            imagePreview.image = image
            self.dismissViewControllerAnimated(true, completion: nil)
            
            imageUploadButton.hidden = false;
            
                       
        }
    }
    
    
    @IBAction func dismissModal(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)

    }
    
    @IBAction func uploadImage(sender: AnyObject) {
        ProgressView.shared.showProgressView(view)
        api!.UploadStream(imagePreview.image!, profileId: String (self.profileId), name: self.name, birthday: self.birthday);
    }
    
    func didRecieveJson(results: NSDictionary) {
        
        ProgressView.shared.hideProgressView()
        var message = results["Status"] as? String
        
       
        view.window?.rootViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func didRecieveError(error: NSError) {
        
        ProgressView.shared.hideProgressView()
        
        let alert = UIAlertView()
        alert.title = "Alert"
        alert.message = "An error has occured!"
        alert.addButtonWithTitle("Ok")
        alert.show()
        
    }
    
    
  
}
