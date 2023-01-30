//
//  ContentView.swift
//  Authentication App
//
//  Created by Raja Rai Kedarnathsingh on 06/04/2022.
//  Copyright © 2022 SBI. All rights reserved.
//

import Foundation
import SwiftUI
import Firebase

struct ContentView: View {
    
    @ObservedObject var expenseViewModel = ExpenseViewModel()
    @State var description = ""
    @State var price = ""
    
    init() {
        expenseViewModel.getAllDataByEmail(email: Auth.auth().currentUser?.email ?? "")
    }
    
    var body: some View {
        
        VStack {
            NavigationView {
                if #available(iOS 14.0, *) {
                    List (expenseViewModel.expenses) { item in
                        
                        HStack {
                            VStack(alignment: .leading) {
                                
                                Text("Description:  \(item.description ?? "")").font(.headline)
            
                                Text("Amount(MUR): \(String(item.price) ?? "")").font(.subheadline)

                            }
                                                            
                            Spacer()
                            
                            Button(action: {
                                expenseViewModel.updateData(expenseToUpdate: item)
                            }, label: {
                                Image(systemName: "pencil")
                            }).buttonStyle(BorderlessButtonStyle())
                            
                            Button(action: {
                                expenseViewModel.deleteData(expenseToDelete: item)
                            }, label: {
                                Image(systemName: "trash")
                            }).buttonStyle(BorderlessButtonStyle())
                            //                    Text(String(item.price))
                            
                        }
                    }.navigationTitle("My Expenses")
                        .navigationBarItems(leading:
                                   Button(action: {
                                      
                                   }) {
                                       HStack {
                                           Image(systemName: "arrow.left")
                        
                                       }
                               })
                } else {
                    // Fallback on earlier versions
                }
            }
            
            Text("Total Expenses(MUR) : " + String(expenseViewModel.getTotalExpensesPrice())).bold()
            
            Divider()
            
            VStack(spacing: 5) {
                
                TextField("Description", text: $description)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Price", text: $price)
                    .keyboardType(.numberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: {
                    expenseViewModel.addNewData(description: description, price: Float(price) ?? 0)
                    
                    description = ""
                    price = ""
                    
                }, label: {
                    Text("Add new Expense")
                })
            }
            .padding()
        }
      
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}

