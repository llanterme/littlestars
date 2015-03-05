

import Foundation

class SessionModel {
    
    var alias: String
    var status: String
    var duration:Int
    
    init (alias:String, status:String, duration:Int) {
        self.alias = alias
        self.status = status
        self.duration = duration
    }
    
    class func getOpenSessions(allResults: NSArray) -> [SessionModel] {
        
        var sessionList = [SessionModel]()
        
        if allResults.count > 0 {
            
            for item in allResults {
          
                let resultsAlias = item["Alias"] as? String ?? ""
                let resultStatus = item["Status"] as? String ?? ""
                let resultDuration = item["Duration"] as? Int ?? 0
                
                  println(resultsAlias)
                
                let newListItem = SessionModel(alias: resultsAlias, status: resultStatus, duration: resultDuration)
                
                sessionList.append(newListItem)
            }
            
        }
        return sessionList
    }
    
    
}
