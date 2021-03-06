//
//  BeaconSettingsViewController.swift
//  BTLE
//
//  Created by Ben Gottlieb on 10/11/15.
//  Copyright © 2015 Stand Alone, inc. All rights reserved.
//

import UIKit
import CoreImage
import Studio

class BeaconSettingsViewController: UIViewController {
	
	@IBOutlet var uuidField: UITextField!
	@IBOutlet var majorField: UITextField!
	@IBOutlet var minorField: UITextField!
	@IBOutlet var enabledSwitch: UISwitch!
	@IBOutlet var imageView: UIImageView!

	class func presentInController(parent: UIViewController) {
		let controller = self.controller() 
		let nav = UINavigationController(rootViewController: controller)
		
		parent.present(nav, animated: true, completion: nil)
	}
	
	@objc func done() {
		UserDefaults.standard.set(self.uuidField.text, forKey: AppDelegate.beaconProximityIDKey)
		UserDefaults.standard.set(self.majorField.text, forKey: AppDelegate.beaconMajorIDKey)
		UserDefaults.standard.set(self.minorField.text, forKey: AppDelegate.beaconMinorIDKey)
		UserDefaults.standard.set(self.enabledSwitch.isOn, forKey: AppDelegate.beaconEnabledKey)
		
		AppDelegate.instance.setupBeacon()
		self.dismiss()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		self.updateQRCodeImage()
	}
	
	@objc func updateQRCodeImage() {
		if let data = self.uuidField.text?.data(using: .isoLatin1, allowLossyConversion: false), let filter = CIFilter(name: "CIQRCodeGenerator") {
			filter.setValue(data, forKey: "inputMessage")
			filter.setValue("Q", forKey: "inputCorrectionLevel")
			if let image = filter.outputImage {
				self.imageView.image = UIImage(ciImage: image)
			}
		}
	}
	
	weak var timer: Timer?
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		self.timer?.invalidate()
		DispatchQueue.main.async {
			self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(BeaconSettingsViewController.updateQRCodeImage), userInfo: nil, repeats: false)
		}
		return true
	}
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return false
	}
	
	
	@objc func cancel() {
		self.dismiss()
	}
	
	func dismiss() {
		self.dismiss(animated: true, completion: nil)
	}
	
	@IBAction func cycleUUID() {
		self.uuidField.text = UUID().uuidString
		self.updateQRCodeImage()
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

		self.navigationItem.title = "iBeacon Settings"
		self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(BeaconSettingsViewController.cancel))
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(BeaconSettingsViewController.done))

		var label = UserDefaults.standard.string(forKey: AppDelegate.beaconProximityIDKey)
		if label.isEmpty { label = UUID().uuidString }
		
		self.uuidField.text = label
		self.majorField.text = UserDefaults.standard.string(forKey: AppDelegate.beaconMajorIDKey)
		self.minorField.text = UserDefaults.standard.string(forKey: AppDelegate.beaconMinorIDKey)
		self.enabledSwitch.isOn = UserDefaults.standard.bool(forKey: AppDelegate.beaconEnabledKey)
		
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
