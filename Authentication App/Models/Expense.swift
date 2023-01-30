//
//  Expenses.swift
//  Authentication App
//
//  Created by Raja Rai Kedarnathsingh on 05/04/2022.
//  Copyright © 2022 SBI. All rights reserved.
//
import SwiftUI
import Foundation

struct Expense: Codable, Identifiable {
    var id: String
    var description: String?
    var price: Float
//    var date: Date
}
