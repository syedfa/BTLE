//
//  ViewController.swift
//  BTLE
//
//  Created by Ben Gottlieb on 2/9/15.
//  Copyright (c) 2015 Stand Alone, inc. All rights reserved.
//

import UIKit
import BTLE
import CoreBluetooth
import SA_Swift



class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
	@IBOutlet var tableView: UITableView!
	@IBOutlet var scanSwitch: UISwitch!
	@IBOutlet var monitorRSSISwitch: UISwitch!
	@IBOutlet var advertiseSwitch: UISwitch!

	var devices: [BTLEPeripheral] = []
	
	func reload() {
		self.devices = BTLE.manager.peripherals
		dispatch_async_main {
			self.tableView.reloadData()
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		BTLE.debugging = true
		BTLE.registerServiceClass(LockService.self, forServiceID: CBUUID(string: "FFF0"))
		BTLE.registerPeripheralClass(LockPeripheral.self)

		//setup scanner
		BTLE.manager.deviceLifetime = 20.0
		BTLE.manager.scanningState = (NSUserDefaults.keyedBool("scanning") ?? false) ? .Active : .Off

		
		//setup advertiser
		var characteristic = BTLEMutableCharacteristic(uuid: CBUUID(string: "FFF4"), properties: nil)
		var service = BTLEMutableService(uuid: CBUUID(string: "FFF3"), isPrimary: true, characteristics: [ characteristic ])
		
		BTLE.manager.peripheralManager.addService(service)
		BTLE.manager.advertisingState = (NSUserDefaults.keyedBool("advertising") ?? false) ? .Active : .Off
		
		self.scanSwitch.on = BTLE.manager.scanningState == .Active || BTLE.manager.scanningState == .StartingUp
		self.advertiseSwitch.on = BTLE.manager.advertisingState == .Active || BTLE.manager.advertisingState == .StartingUp
		self.monitorRSSISwitch.on = BTLE.manager.monitorRSSI

	
	
		self.addAsObserver(BTLE.notifications.peripheralDidDisconnect, selector: "reload", object: nil)
		self.addAsObserver(BTLE.notifications.peripheralDidConnect, selector: "reload", object: nil)
		self.addAsObserver(BTLE.notifications.didDiscoverPeripheral, selector: "reload", object: nil)
		self.addAsObserver(BTLE.notifications.peripheralDidUpdateRSSI, selector: "reload", object: nil)
		self.addAsObserver(BTLE.notifications.peripheralDidBeginLoading, selector: "reload", object: nil)
		self.addAsObserver(BTLE.notifications.peripheralDidFinishLoading, selector: "reload", object: nil)
		self.addAsObserver(BTLE.notifications.peripheralDidUpdateName, selector: "reload", object: nil)
		self.addAsObserver(BTLE.notifications.peripheralDidLoseComms, selector: "reload", object: nil)
		self.addAsObserver(BTLE.notifications.peripheralDidRegainComms, selector: "reload", object: nil)

		if self.scanSwitch.on {
			self.timer = NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: "reload", userInfo: nil, repeats: true)
		}
	}
	
	var timer: NSTimer?
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		
	}
	
	@IBAction func toggleScanning() {
		BTLE.manager.scanningState = self.scanSwitch.on ? .Active : .Idle

		if self.scanSwitch.on {
			self.timer = NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: "reload", userInfo: nil, repeats: true)
		} else {
			self.timer?.invalidate()
			self.timer = nil
		}
		NSUserDefaults.setKeyedBool(self.scanSwitch.on, forKey: "scanning")
	}

	@IBAction func toggleRSSIMonitoring() {
		BTLE.manager.monitorRSSI = !BTLE.manager.monitorRSSI
	}
	
	@IBAction func toggleAdvertising() {
		BTLE.manager.advertisingState = self.advertiseSwitch.on ? .Active : .Idle
		NSUserDefaults.setKeyedBool(self.advertiseSwitch.on, forKey: "advertising")
	}
	
	@IBAction func configureServices() {
	
	}
	
	func connectToggled(toggle: UISwitch) {
		var device = self.devices[toggle.tag]
		
		if toggle.on {
			device.connect()
		} else {
			device.disconnect()
		}
		
		self.tableView.beginUpdates()
		self.tableView.reloadRowsAtIndexPaths([ NSIndexPath(forRow: toggle.tag, inSection: 0)], withRowAnimation: .Automatic)
		self.tableView.endUpdates()
	}
	
	//=============================================================================================
	//MARK:
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.devices.count
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		var cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "cell")
		var device = self.devices[indexPath.row]
		
		cell.textLabel?.text = "\(device.summaryDescription)"

		var toggle = UISwitch(frame: CGRectZero)
		toggle.on = device.state == .Connected || device.state == .Connecting
		toggle.tag = indexPath.row
		toggle.addTarget(self, action: "connectToggled:", forControlEvents: .ValueChanged)
		
		cell.accessoryView = toggle
		
		var seconds = Int(abs(device.lastCommunicatedAt.timeIntervalSinceNow))
		cell.detailTextLabel?.text = "\(seconds) sec since last ping, \(device.services.count) services"
		
		if device.state == .Undiscovered {
			cell.textLabel?.textColor = UIColor.redColor()
		}
		
		return cell
	}
	
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		var device = self.devices[indexPath.row]
		
		println("\(device.fullDescription)")
	}

}


