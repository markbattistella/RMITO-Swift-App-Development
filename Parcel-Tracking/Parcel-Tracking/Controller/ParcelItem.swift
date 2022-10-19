//
//  ParcelItem.swift
//  mbParcelTracking
//
//  Created by Mark Battistella on 1/6/20.
//  Copyright © 2020 Mark Battistella. All rights reserved.
//

import Foundation

struct Parcel: Codable {
	
	// what do we want
	var customerName:		String
	var customerAddress:	String
	var trackingNumber:		String
	var trackingStatus:		Double
	var deliveryDate:		Date
	var deliveryNote:		String? // optional
	var lastUpdated:		Date

	// format the date
	static let dateTimeFormat: DateFormatter = {
		let dateFormat = DateFormatter()
		dateFormat.dateStyle = .short
		dateFormat.timeStyle = .short
		return dateFormat
	}()

	// data location
	static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
	static let ArchiveURL = DocumentsDirectory.appendingPathComponent("parcels").appendingPathExtension("plist")

	// save the data
	static func saveParcels(_ parcels: [Parcel]) {
		let propertyListEncoder = PropertyListEncoder()
		let codedParcels = try? propertyListEncoder.encode(parcels)
		try? codedParcels?.write(to: ArchiveURL, options: .noFileProtection)
	}
	
	// load the saved parcels
	static func loadSavedParcels() -> [Parcel]? {
		guard let codedParcels = try? Data(contentsOf: ArchiveURL) else { return nil }
		let propertyListDecoder = PropertyListDecoder()
		return try? propertyListDecoder.decode(Array<Parcel>.self, from: codedParcels)
	}

	// load sample data
	static func loadSampleParcels() -> [Parcel] {
		let parcel1 = Parcel(customerName: "Bob Dylan", customerAddress: "123 Fake Street", trackingNumber: "N123456789", trackingStatus: 1.0, deliveryDate: Date().addingTimeInterval(24*3600), deliveryNote: "", lastUpdated: Date())
		let parcel2 = Parcel(customerName: "Morgan Freeman", customerAddress: "123 Not Fake Street", trackingNumber: "GH654218", trackingStatus: 2.0, deliveryDate: Date(), deliveryNote: "", lastUpdated: Date())
		let parcel3 = Parcel(customerName: "Natalie Portman", customerAddress: "65 Green Road", trackingNumber: "N123456789", trackingStatus: 3.0, deliveryDate: Date(), deliveryNote: "Test note", lastUpdated: Date())
		
		return [parcel1, parcel2, parcel3]
	}
}
