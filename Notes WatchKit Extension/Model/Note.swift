//
//  Note.swift
//  Notes WatchKit Extension
//
//  Created by hosein on 5/11/1401 AP.
//

import Foundation

struct Note : Identifiable , Codable {
    let id:UUID
    let text:String
}
