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
        
        let size = CGSizeApplyAffineTransform(image.size, CGAffineTransformMakeScale(0.5, 0.5))
        let hasAlpha = false
        let scale: CGFloat = 0.0
        
        UIGraphicsBeginImageContextWithOptions(size, !hasAlpha, scale)
        image.drawInRect(CGRect(origin: CGPointZero, size: size))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        
        var manager = Manager.sharedInstance;
        manager.session.configuration.HTTPAdditionalHeaders = ["Content-Type": "application/octet-stream"]
        
        var url = Utils.getPlistValue("API") + "/UploadFile?fileName=file.jpg" + "_" + profileId + "_" + name + "_" + birthday
        
        var imageData:NSData = UIImageJPEGRepresentation(scaledImage, 0.3)
        
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
    
    func getOpenSessions() {
        
        var manager = Manager.sharedInstance;
        manager.session.configuration.HTTPAdditionalHeaders = ["Content-Type": "application/json"]
        
        Alamofire.request(.GET, Utils.getPlistValue("API") + "/OpenSessions", parameters: nil)
            .responseJSON { (request, response, JSON, error) in
                if(error == nil) {
                    
                    let jsonResults = JSON as Dictionary<String, NSObject>
                     self.delegate.didRecieveJson!(jsonResults)
                }
        }
        
    }
    
    func GetProfileOverview(profilePin:String) {
        
        
        var manager = Manager.sharedInstance;
        manager.session.configuration.HTTPAdditionalHeaders = ["Content-Type": "application/json"]
        
        Alamofire.request(.GET, Utils.getPlistValue("API") + "/ProfileOverview/" + profilePin, parameters: nil)
            .responseJSON { (request, response, JSON, error) in
               
               
                if(error == nil) {
                 //   let jsonResults = JSON as Dictionary<String, NSObject>
                      let jsonDictionary = (JSON as NSDictionary)
                    self.delegate.didRecieveJson!(jsonDictionary)
                } else {
                    self.delegate.didRecieveError!(error!);
                }        }
        
    }
    
    func CreateSession(alias:String, startDate:String, startTime:String, duration:String) {
        
        let parameters = [
            
            "session": [
                "Alias": alias,
                "StartDate": startDate,
                "StartTime": startTime,
                "Duration": duration
                
                
            ]
        ]
        
        Alamofire.request(.POST, Utils.getPlistValue("API") + "/CreateSession", parameters: parameters,encoding: .JSON)
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

}


