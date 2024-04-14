//
//  Query+Ext.swift
//  MobileAndon
//
//  Created by Ricky Silitonga on 03/04/24.
//

import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

extension Query {
    func aggregateCount() async throws -> Int {
        let snapshot = try await self.count.getAggregation(source: .server)
        return Int(truncating: snapshot.count)
    }
    
    func getDocuments<T>(as type: T.Type) async throws -> [T] where T : Decodable {
        
        try await getDocumentsWithSnapshot(as: type).products
    }
    
    func getDocumentsWithSnapshot<T>(as type: T.Type) async throws -> (products: [T], lastDocument: DocumentSnapshot?) where T : Decodable {
        let snapshot = try await self.getDocuments()
        
        let products = try snapshot.documents.map({ document in
            try document.data(as: T.self)
        })
        
        return (products, snapshot.documents.last)
    }
    
    func addSnapshotListener<T>(as type: T.Type) -> ((AnyPublisher<[T], Error>), ListenerRegistration) where T : Decodable {
        let publisher = PassthroughSubject<[T], Error>()
        let listener = self.addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            let data: [T] = documents.compactMap({ try? $0.data(as: T.self) })
            publisher.send(data)
        }
        return (publisher.eraseToAnyPublisher(), listener)
    }
}

