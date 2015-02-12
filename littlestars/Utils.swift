
import Foundation

class Utils {

class func getPlistValue(itemValue:String) -> String {
    
    let path = NSBundle.mainBundle().pathForResource("config", ofType: "plist")
    let dict = NSDictionary(contentsOfFile: path!)
    
    return dict?.objectForKey(itemValue) as String;
}

}