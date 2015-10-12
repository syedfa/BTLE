//
//  BeaconSettingsViewController.swift
//  BTLE
//
//  Created by Ben Gottlieb on 10/11/15.
//  Copyright © 2015 Stand Alone, inc. All rights reserved.
//

import UIKit
import Gulliver

class BeaconSettingsViewController: UIViewController {
	
	@IBOutlet var uuidField: UITextField!
	@IBOutlet var majorField: UITextField!
	@IBOutlet var minorField: UITextField!
	@IBOutlet var enabledSwitch: UISwitch!

	class func presentInController(parent: UIViewController) {
		let controller = self.controller() as! BeaconSettingsViewController
		let nav = UINavigationController(rootViewController: controller)
		
		parent.presentViewController(nav, animated: true, completion: nil)
	}
	
	func done() {
		NSUserDefaults.set(self.uuidField.text, forKey: AppDelegate.beaconProximityIDKey)
		NSUserDefaults.set(self.majorField.text, forKey: AppDelegate.beaconMajorIDKey)
		NSUserDefaults.set(self.minorField.text, forKey: AppDelegate.beaconMinorIDKey)
		NSUserDefaults.set(self.enabledSwitch.on, forKey: AppDelegate.beaconEnabledKey)
		
		AppDelegate.instance.setupBeacon()
		self.dismiss()
	}
	
	func cancel() {
		self.dismiss()
	}
	
	func dismiss() {
		self.dismissViewControllerAnimated(true, completion: nil)
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

		self.navigationItem.title = "iBeacon Settings"
		self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: "cancel")
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: "done")

		var label = NSUserDefaults.get(AppDelegate.beaconProximityIDKey) ?? ""
		if label.length == 0 { label = "6EA439F2-846F-46C0-9860-28AEBA9B0A67" }
		
		self.uuidField.text = label
		self.majorField.text = NSUserDefaults.get(AppDelegate.beaconMajorIDKey)
		self.minorField.text = NSUserDefaults.get(AppDelegate.beaconMinorIDKey)
		self.enabledSwitch.on = NSUserDefaults.get(AppDelegate.beaconEnabledKey) ?? false
		
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
