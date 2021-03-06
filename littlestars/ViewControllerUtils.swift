import Foundation
import UIKit

class ProgressView {
    var containerView = UIView()
    var progressView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    
    class var shared: ProgressView {
    struct Static {
        static let instance: ProgressView = ProgressView()
        }
        return Static.instance
    }
    
    func showProgressView(view: UIView) {
        containerView.frame = view.frame
        containerView.center = view.center
        containerView.backgroundColor = UIColor(netHex: 0xffffff)
        
        progressView.frame = CGRectMake(0, 0, 80, 80)
        progressView.center = view.center
        progressView.backgroundColor = UIColor(netHex: 0x444444)
        progressView.clipsToBounds = true
        progressView.layer.cornerRadius = 10
        
        activityIndicator.frame = CGRectMake(0, 0, 40, 40)
        activityIndicator.activityIndicatorViewStyle = .WhiteLarge
        activityIndicator.center = CGPointMake(progressView.bounds.width / 2, progressView.bounds.height / 2)
        
        progressView.addSubview(activityIndicator)
        containerView.addSubview(progressView)
        view.addSubview(containerView)
        
        activityIndicator.startAnimating()
    }
    
    func hideProgressView() {
        activityIndicator.stopAnimating()
        containerView.removeFromSuperview()
    }
}