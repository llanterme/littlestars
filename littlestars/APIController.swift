import UIKit
import Foundation
import Alamofire



@objc protocol APIControllerProtocol {
    optional func didRecieveJson(results: NSDictionary)
    optional func didRecieveError(error: NSError)
    optional func didRecieveJsonArray(results: NSArray)
}

class APIController {
    
    var delegate: APIControllerProtocol;
    
    init(delegate: APIControllerProtocol) {
        self.delegate = delegate
    }

    func CreateProfile(profile:ProfileModel) {
    
    let parameters = [
        
        "profile": [
            "Email": profile.email,
            "Cell": profile.cell,
            "Surname": profile.surname,
            "Name": profile.name
            
        ]
    ]
    
    Alamofire.request(.POST, Utils.getPlistValue("API") + "/CreateProfile", parameters: parameters,encoding: .JSON)
        .responseJSON
        { (request, response, JSON, error) in
            println(error)
            println(response)
            if (error == nil) {
                let jsonResults = JSON as Dictionary<String, NSObject>
                self.delegate.didRecieveJson!(jsonResults)
            } else {
                self.delegate.didRecieveError!(error!);
            }
            
    }
    
}
    
   func CreateStudent(student:StudentModel) {
    
        let parameters = [
            
            "student": [
                "Birthday": student.birthday,
                "Name": student.name,
                "ProfileId": student.profileId
               
                
            ]
        ]
        
        
        Alamofire.request(.POST, Utils.getPlistValue("API") + "/CreateStudent", parameters: parameters,encoding: .JSON)
            .responseJSON
            { (request, response, JSON, error) in
                println(error)
                println(response)
                if (error == nil) {
                    let jsonResults = JSON as Dictionary<String, NSObject>
                    self.delegate.didRecieveJson!(jsonResults)
                } else {
                    self.delegate.didRecieveError!(error!);
                }
                
        }
        
    }
    
    func UploadStream(image:UIImage, profileId:String, name:String, birthday:String) {
        
        var manager = Manager.sharedInstance;
        manager.session.configuration.HTTPAdditionalHeaders = ["Content-Type": "application/octet-stream"]
        
        var url = Utils.getPlistValue("API") + "/UploadFile?fileName=file.jpg" + "_" + profileId + "_" + name + "_" + birthday
        
        var imageData:NSData = UIImageJPEGRepresentation(image, 30)
        
        Alamofire.upload(.POST, url,  imageData)
            .responseJSON { (request, response, JSON, error) in
                
                if (error == nil) {
                    let jsonResults = JSON as Dictionary<String, NSObject>
                    self.delegate.didRecieveJson!(jsonResults)
                    
                } else {
                    self.delegate.didRecieveError!(error!);
                }
                
        }
        
        
    }

}


