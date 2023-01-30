//
//  ExpenseViewModel.swift
//  Authentication App
//
//  Created by Raja Rai Kedarnathsingh on 05/04/2022.
//  Copyright © 2022 SBI. All rights reserved.
//

import Foundation
import FirebaseFirestore
import Firebase

class ExpenseViewModel: ObservableObject {

    @Published var expenses = [Expense]()
//    @Published var expenses2 = ["cs","dsads","dsad"]

    private var db = Firestore.firestore()

    func getAllData() {
        
        db.collection("expenses").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }

            self.expenses = documents.map { (queryDocumentSnapshot) -> Expense in
                let data = queryDocumentSnapshot.data()
                let id = queryDocumentSnapshot.documentID
                let desc = data["description"] as? String ?? ""
                let price = data["price"] as? Float ?? 0
                return Expense(id: id, description: desc, price: price)
            }
        }
    }
    
    func getAllDataByEmail(email: String) {
        
        db.collection("expenses").whereField("userEmail", isEqualTo: email)
            .getDocuments() { (querySnapshot, err) in
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }

                self.expenses = documents.map { (queryDocumentSnapshot) -> Expense in
                    let data = queryDocumentSnapshot.data()
                    let id = queryDocumentSnapshot.documentID
                    let desc = data["description"] as? String ?? ""
                    let price = data["price"] as? Float ?? 0
                    print(data)
                    return Expense(id: id, description: desc, price: price)
                }
        }

    }

    func addNewData(description: String, price: Float) {
       do {
           let loggedInUserEmail: String = Auth.auth().currentUser?.email ?? ""
           
           _ = try db.collection("expenses").addDocument(data: ["description": description, "price": price, "userEmail": loggedInUserEmail], completion: { error in
               
               if error == nil {
                   self.getAllDataByEmail(email: loggedInUserEmail)
               }
               else {
                   
               }
           })
       }
       catch {
           print(error.localizedDescription)
       }
   }
    
    func updateData(expenseToUpdate: Expense) {

        db.collection("expenses").document(expenseToUpdate.id).setData(["description" : "Updated:\(expenseToUpdate.description ?? "")"], merge: true) { error in
            
            if error == nil {
                let loggedInUserEmail: String = Auth.auth().currentUser?.email ?? ""
                self.getAllDataByEmail(email: loggedInUserEmail)
            }
        }
    }

    func deleteData(expenseToDelete: Expense) {
        
        db.collection("expenses").document(expenseToDelete.id).delete { error in
            
            if error == nil {
                //Update the UI from the main thread
                DispatchQueue.main.async {
                    self.expenses.removeAll { expense in
                        print(expenseToDelete.id)
                        return expense.id == expenseToDelete.id
                    }
                }
            }
        }
    }
        
    func getTotalExpensesPrice() -> Float {
        
        var total: Float = 0
        
        for expense in self.expenses {
            total += expense.price
        }
        
        return total
    }
}
