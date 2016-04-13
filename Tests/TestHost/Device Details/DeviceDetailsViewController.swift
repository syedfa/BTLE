//
//  DeviceDetailsViewController.swift
//  BTLE
//
//  Created by Ben Gottlieb on 4/19/15.
//  Copyright (c) 2015 Stand Alone, inc. All rights reserved.
//

import UIKit
import BTLE
import Gulliver
import GulliverEXT

class DeviceDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
	deinit {
		self.removeAsObserver()
	}
	
	let peripheral: BTLEPeripheral
	@IBOutlet var tableView: UITableView!
	@IBOutlet var connectedSwitch: UISwitch!
	
	var refreshControl: UIRefreshControl?
	
	
	func startLoading() {
		Dispatch.main.async {
			self.refreshControl?.beginRefreshing()
		}
	}

	func finishLoading() {
		Dispatch.main.async {
			self.refreshControl?.endRefreshing()
		}
		self.updateSections()
	}

	init(peripheral per: BTLEPeripheral) {
		peripheral = per
		
		super.init(nibName: "DeviceDetailsViewController", bundle: nil)
		
		self.addAsObserver(BTLE.notifications.peripheralDidBeginLoading, selector: "startLoading")
		self.addAsObserver(BTLE.notifications.peripheralDidFinishLoading, selector: "finishLoading")
		self.addAsObserver(BTLE.notifications.peripheralDidConnect, selector: "updateConnectedState")
		self.addAsObserver(BTLE.notifications.peripheralDidDisconnect, selector: "updateConnectedState")
		self.updateSections()
		
		self.updateConnectedState()
	}
	
	func updateConnectedState() {
		dispatch_async(dispatch_get_main_queue()) {
			self.tableView?.alpha = (self.peripheral.state == .Connected) ? 1.0 : 0.5
			self.title = self.peripheral.name + ((self.peripheral.state == .Connected) ? " Connected" : " Disconnected")
			self.connectedSwitch.on = (self.peripheral.state == .Connected)
		}
	}

	required init(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.connectedSwitch)
		
		self.refreshControl = UIRefreshControl(frame: CGRectZero)
		self.tableView.addSubview(self.refreshControl!)
		self.refreshControl?.addTarget(self, action: "reloadDevice", forControlEvents: .ValueChanged)

		self.connectedSwitch.on = self.peripheral.state == .Connected
		
		self.tableView.registerNib(UINib(nibName: "CharacteristicTableViewCell", bundle: nil), forCellReuseIdentifier: "characteristic")
		
		self.updateConnectedState()
        // Do any additional setup after loading the view.
    }
	
	func reloadDevice() {
		self.peripheral.reloadServices()
	}
	
	override func viewWillAppear(animated: Bool) {
		self.navigationController?.navigationBarHidden = false
	}

	func updateSections() {
		self.sections = [nil]
		
		for service in self.peripheral.services {
			self.sections.append(service)
		}
		
		Dispatch.main.async {
			self.tableView.reloadData()
		}
	}
	
	@IBAction func toggleConnected() {
		if self.connectedSwitch.on {
			self.peripheral.connect()
		} else {
			self.peripheral.disconnect()
		}
	}
	

	
	
	//=============================================================================================
	//MARK: Tableview
	
	var sections: [BTLEService?] = []

	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if let service = self.sections[section] {
			return service.characteristics.count
		} else {
			return self.peripheral.advertisementData.count
		}
	}
	
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return self.sections.count
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		if let service = self.sections[indexPath.section] {
			let cell = tableView.dequeueReusableCellWithIdentifier("characteristic", forIndexPath: indexPath) as! CharacteristicTableViewCell
			let chr = service.characteristics[indexPath.row]
			
			cell.characteristic = chr
			
			return cell
 		} else {
			let cell = UITableViewCell(style: .Value1, reuseIdentifier: "cell")
			var info = self.peripheral.advertisementData
			var keys = ((info as NSDictionary).allKeys as! [String]).sort(<)
			let key = keys[indexPath.row]
			let value = info[key] as? CustomStringConvertible
			
			cell.textLabel?.text = key
			cell.detailTextLabel?.text = (value?.description ?? "").stringByReplacingOccurrencesOfString("\n", withString: "")
			
			return cell
		}
	}
	
	func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let label = UILabel(frame: CGRect(x: 0, y: 0, width: 320, height: 22))
		label.text = self.tableView(tableView, titleForHeaderInSection: section)
		label.backgroundColor = UIColor.orangeColor()
		label.textColor = UIColor.blackColor()
		
		return label
	}
	
	func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		if let service = self.sections[section] {
			return service.uuid.description
		} else {
			return "Advertisement Data"
		}
	}
	
	func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		if indexPath.section == 0 { return 22 }
		
		return 100
	}
	
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		if let service = self.sections[indexPath.section] {
			let chr = service.characteristics[indexPath.row]
			
			chr.reload()
			print("\(chr)")
		} else {
			var info = self.peripheral.advertisementData
			var keys = ((info as NSDictionary).allKeys as! [String]).sort(<)
			let key = keys[indexPath.row]
			let value = info[key] as? CustomStringConvertible
			
			print("\(value)")
		}
	}
}
