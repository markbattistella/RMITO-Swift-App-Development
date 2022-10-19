//
//  ParcelDetailTableViewController.swift
//  mbParcelTracking
//
//  Created by Mark Battistella on 1/6/20.
//  Copyright © 2020 Mark Battistella. All rights reserved.
//

import UIKit

class ParcelDetailTableViewController: UITableViewController {
	
	// variables
	var parcel: Parcel?
	@IBOutlet weak var customerName: UITextField!
	@IBOutlet weak var customerAddress: UITextField!
	@IBOutlet weak var trackingNumber: UITextField!
	@IBOutlet weak var slider: UISlider!
	@IBOutlet weak var deliveryDateLabel: UILabel!
	@IBOutlet weak var deliveryDatePicker: UIDatePicker!
	@IBOutlet weak var lastUpdateDateLabel: UILabel!
	@IBOutlet weak var lastUpdateDatePicker: UIDatePicker!
	@IBOutlet weak var otherInformation: UITextView!
	@IBOutlet weak var saveButton: UIBarButtonItem!

	// set the heights and hide the picker
	var isPickerHidden = true
	let statusIndexPath = IndexPath(row: 1, section: 1)
	let dateLabelIndexPath = IndexPath(row: 2, section: 1)
	let datePickerIndexPath = IndexPath(row: 3, section: 1)
	let notesTextIndexPath = IndexPath(row: 0, section: 2)
	@IBOutlet weak var datePickerCell: UITableViewCell!

	let normalCellHeight: CGFloat = 44
	let largeCellHeight: CGFloat = 200

	
	override func viewDidLoad() {
        super.viewDidLoad()

		// load the existing data
		if let parcel = parcel {
			navigationItem.title = "Edit Parcel"
			customerName.text = parcel.customerName
			customerAddress.text = parcel.customerAddress
			trackingNumber.text = parcel.trackingNumber
			slider.value = Float(parcel.trackingStatus)
			deliveryDatePicker.date = parcel.deliveryDate
			lastUpdateDatePicker.date = parcel.lastUpdated
			otherInformation.text = parcel.deliveryNote

		// new entry: update the date label from picker
		} else {
			
			// set date time to now
			deliveryDatePicker.date = Date()
		}

		// hide the picker
		datePickerCell.isHidden = false

		// disable the save button if empty
		updateSaveButton()

		// update the delivery date picker
		updateDeliveryDateLabel(date: deliveryDatePicker.date)

		// update the last update picker
		updateLastUpdatedLabel(date: lastUpdateDatePicker.date)
	}
	
	
	// MARK: - Table function

	// row heights
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		switch indexPath {
			case datePickerIndexPath :
				return isPickerHidden ? 0 : deliveryDatePicker.frame.height + 20
			case notesTextIndexPath:
				return largeCellHeight
			case statusIndexPath :
				return normalCellHeight + 32
			default :
				return normalCellHeight
		}
	}
	
	// toggle the datepicker
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if indexPath == dateLabelIndexPath {

			// turn the picker to opposite bool
			isPickerHidden = !isPickerHidden

			// change the colour
			deliveryDateLabel.textColor = isPickerHidden ? UIColor(named: "mbWhiteBlack") : tableView.tintColor

			// animate the cell
			tableView.beginUpdates()
			tableView.endUpdates()
		}
	}
	
	// dont allow saving unless these are filled
	func updateSaveButton() {
        let customerNameText	= customerName.text		?? ""
        let customerAddressText	= customerAddress.text	?? ""
        let trackingNumberText	= trackingNumber.text	?? ""

		saveButton.isEnabled = ((!customerNameText.isEmpty && !customerAddressText.isEmpty) && !trackingNumberText.isEmpty)
	}

	// update the label with the datepicker
	func updateDeliveryDateLabel(date: Date) {
		deliveryDateLabel.text = Parcel.dateTimeFormat.string(from: date)
	}

	// update the label with the datepicker
	func updateLastUpdatedLabel(date: Date) {
		lastUpdateDateLabel.text = Parcel.dateTimeFormat.string(from: date)
	}
	
	// round the slider for snapping
	@IBAction func onSliderChange(_ sender: UISlider) {
		slider.value = round(sender.value)
	}

	// update the save button on keystroke
	@IBAction func textEditingChanged(_ sender: UITextField) {
		updateSaveButton()
	}
	
	// returned button pressed
	@IBAction func returnedPressed(_ sender: UITextField) {
		sender.resignFirstResponder()
	}
	
	// date picker trigger
	@IBAction func datePickerChanged(_ sender: UIDatePicker) {
		updateDeliveryDateLabel(date: deliveryDatePicker.date)
	}

	
	// MARK: - Navigation

	// pass the data to the struct for saving
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		super.prepare(for: segue, sender: sender)

		guard segue.identifier == "saveUnwind" else { return }

		let customerName = self.customerName.text!
		let customerAddress = self.customerAddress.text!
		let trackingNumber = self.trackingNumber.text!
		let parcelStatus = self.slider.value
		let deliveryDatePicker = self.deliveryDatePicker.date
		let lastUpdatedDate = Date()
		let otherInformation = self.otherInformation.text

		parcel = Parcel(customerName: customerName, customerAddress: customerAddress, trackingNumber: trackingNumber, trackingStatus: Double(parcelStatus), deliveryDate: deliveryDatePicker, deliveryNote: otherInformation, lastUpdated: lastUpdatedDate)
	}

}
