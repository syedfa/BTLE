//
//  CharacteristicTableViewCell.swift
//  BTLE
//
//  Created by Ben Gottlieb on 4/21/15.
//  Copyright (c) 2015 Stand Alone, inc. All rights reserved.
//

import UIKit
import BTLE
import SA_Swift
import CoreBluetooth

class CharacteristicTableViewCell: UITableViewCell {
	@IBOutlet var nameAndPropertiesLabel: UILabel!
	@IBOutlet var stringValueLabel: UILabel!
	@IBOutlet var dataValueLabel: UILabel!
	@IBOutlet var notifySwitch: UISwitch!
	@IBOutlet var writeButton: UIButton!
	
	deinit {
		self.removeAsObserver()
	}
	
	var characteristic: BTLECharacteristic? { didSet {
			self.updateUI()
		}
	}
	
    override func awakeFromNib() {
        super.awakeFromNib()
		self.addAsObserver(BTLE.notifications.characteristicDidUpdate, selector: "updateUI", object: nil)
		self.addAsObserver(BTLE.notifications.characteristicListeningChanged, selector: "updateUI", object: nil)
		
		self.updateUI()
        // Initialization code
    }
	
	func updateUI() {
		dispatch_async_main	{
			if let chr = self.characteristic {
				self.notifySwitch.on = (chr.listeningState == .Listening || chr.listeningState == .StartingToListen)
				self.notifySwitch.enabled = (chr.listeningState == .Listening || chr.listeningState == .NotListening)
				var desc = chr.cbCharacteristic.UUID.description
				self.nameAndPropertiesLabel?.text = desc.substringToIndex(desc.index(20)) + ": " + chr.propertiesAsString
				
				self.notifySwitch.hidden = !chr.canNotify
				self.writeButton.hidden = !chr.centralCanWriteTo
				
				if let data = chr.dataValue {
					self.stringValueLabel?.text = String(data: data, encoding: NSUTF8StringEncoding) ?? ""
					self.dataValueLabel?.text = data.hexString
				} else {
					self.dataValueLabel?.text = ""
					self.stringValueLabel?.text = ""
				}
			}
		}
	}

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	
	@IBAction func toggledNotify() {
		self.characteristic?.listenForUpdates(self.notifySwitch.on)
	}
	
	@IBAction func writeTo() {
		var string = NSDate().localTimeString(timeStyle: .FullStyle).uppercaseString
		
		var data = string.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)

		self.characteristic?.publishValue(data!, withResponse: true)
	}
}
