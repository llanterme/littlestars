import Foundation

class ProfileModel {
    
    var surname: String;
    var name: String;
    var cell: String;
    var email: String;
    
    init(surname:String, name:String, cell:String, email:String) {
        self.surname = surname
        self.name = name
        self.cell = cell
        self.email = email
    }
    
    
}
