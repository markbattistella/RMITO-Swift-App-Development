//
//  ParcelListTableViewController.swift
//  mbParcelTracking
//
//  Created by Mark Battistella on 1/6/20.
//  Copyright © 2020 Mark Battistella. All rights reserved.
//

import UIKit

class ParcelListTableViewController: UITableViewController {
	
	// create the variable
	var parcels = [Parcel]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// load sample data or saved data
		if let savedParcels = Parcel.loadSavedParcels() {
			parcels = savedParcels
		} else {
			parcels = Parcel.loadSampleParcels()
		}
	}
	
	// MARK: - Table view data source
	
	// how many rows to return
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return parcels.count
	}
	
	// retun the cell data
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		// use the reusable identifier
		// guard is for returning the error if failed
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "ParcelCellIdentifier") as? ParcelListTableViewCell else {
			fatalError("Could not dequeue a cell")
		}
		
		// get the info from the row index
		let parcel = parcels[indexPath.row]
		
		// return the info
		cell.cellCustomerName.text = parcel.customerName
		cell.cellCustomerAddress.text = parcel.customerAddress
		
		switch parcel.trackingStatus {
		case 1.0:
			cell.cellTrackingStatus.tintColor		= .systemRed
		case 2.0:
			cell.cellTrackingStatus.tintColor		= .systemOrange
		case 3.0:
			cell.cellTrackingStatus.tintColor	= .systemGreen
		default:
			cell.cellTrackingStatus.tintColor	= .systemGray
			cell.cellTrackingStatus.image		= UIImage(systemName: "circle")
		}
		return cell
	}
	
	// row height
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 56
	}

	// can we edit the rows
	override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		return true
	}
	
	// swipe to delete
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			parcels.remove(at: indexPath.row)
			tableView.deleteRows(at: [indexPath], with: .left)
			Parcel.saveParcels(parcels)
		}
	}
	
	// show the info notification
	@IBAction func infoButton(_ sender: UIBarButtonItem) {
		let actionSheetController: UIAlertController = UIAlertController(title: "Delivery status", message: "Red: being packed\nYellow: on route\nGreen: delivered", preferredStyle: .alert)
		let nextAction: UIAlertAction = UIAlertAction(title: "Okay", style: .default) {
			action -> Void in
		}
		actionSheetController.addAction(nextAction)
		self.present(actionSheetController, animated: true, completion: nil)
	}
	
	
	// MARK: - Navigation
	
	// what to do when leaving detail view
	@IBAction func unwindParcelList(segue: UIStoryboardSegue) {
		guard segue.identifier == "saveUnwind" else { return }
		let sourceViewController = segue.source as! ParcelDetailTableViewController
		
		if let parcel = sourceViewController.parcel {
			
			// update the existing row
			if let selectedIndexPath = tableView.indexPathForSelectedRow {
				parcels[selectedIndexPath.row] = parcel
				tableView.reloadRows(at: [selectedIndexPath], with: .none)
				
				// insert the new entry
			} else {
				let newIndexPath = IndexPath(row: parcels.count, section: 0 )
				parcels.append(parcel)
				tableView.insertRows(at: [newIndexPath], with: .automatic)
			}
		}
		Parcel.saveParcels(parcels)
	}
	
	// what to pass for edit page
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier ==  "editParcel" {
			let parcelDetailTableViewController = segue.destination as! ParcelDetailTableViewController
			let indexPath = tableView.indexPathForSelectedRow!
			let selectedParcel = parcels[indexPath.row]
			parcelDetailTableViewController.parcel = selectedParcel
		}
	}
	
	
}
