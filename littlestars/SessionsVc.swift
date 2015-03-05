

import UIKit

class SessionsVc: UIViewController, UITableViewDataSource, UITableViewDelegate, APIControllerProtocol {
    
    var api : APIController?
    let kCellIdentifier: String = "OpenSessionsCell"
    var sessionsList = [SessionModel]()

    @IBOutlet weak var openSessionTableView: UITableView!
    
    override func viewDidLoad() {
    
        
        super.viewDidLoad()
        
        ProgressView.shared.showProgressView(view)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationItem.hidesBackButton = false
        api = APIController(delegate: self)
        api!.getOpenSessions()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return sessionsList.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell: SessionsCell = tableView.dequeueReusableCellWithIdentifier(kCellIdentifier) as SessionsCell;
        
        let session = self.sessionsList[indexPath.row]
        
        
        cell.SessionAlias.text = session.alias
        
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor(netHex:0x5BCAFF)
            
        } else {
            cell.backgroundColor = UIColor(netHex:0xE0F8D8)
            
            
        }
      
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.openSessionTableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func didRecieveJson(results: NSDictionary) {
        
        ProgressView.shared.hideProgressView()
        
        if(results.count != 0) {
            
            var resultsArr: NSArray = results["Sessions"] as? NSArray ?? []
            
            self.sessionsList = SessionModel.getOpenSessions(resultsArr)
            self.openSessionTableView!.reloadData()
        }
    }
    
    
    @IBAction func createSession(sender: AnyObject) {
        
    }

   

}
