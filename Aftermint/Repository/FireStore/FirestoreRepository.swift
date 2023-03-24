//
//  FIrestoreRepository.swift
//  Aftermint
//
//  Created by Platfarm on 2023/03/20.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift

class FirestoreRepository {

    static let shared: FirestoreRepository = FirestoreRepository()
    private init() {}
    
    let db = Firestore.firestore()
    
    func saveCard(_ card: Card) {
        
        let docRefForCard = db.collection(K.FStore.nftCardCollectionName).document(card.tokenId)
        let docRefForTotal = db.collection(K.FStore.nftCardCollectionName).document(K.FStore.totalDocumentName)
        
        /// Save card data
        docRefForCard.setData([
            K.FStore.collectionIdFieldKey: card.collectionId,
            K.FStore.imageUriFieldKey: card.imageUri,
            K.FStore.tokenIdFieldKey: card.tokenId,
            //            K.FStore.countFieldKey: FieldValue.increment(Int64(1))
            K.FStore.countFieldKey: FieldValue.increment(card.count)
        ], merge: true)
        
        /// Save total count
        docRefForTotal.setData([
            //            K.FStore.countFieldKey: FieldValue.increment(Int64(1))
            K.FStore.countFieldKey: FieldValue.increment(card.count)
        ], merge: true)
        
    }
    
    
    func getAllCard(completion: @escaping (([Card]?) -> ())) {

        let docRefForCard = db.collection(K.FStore.nftCardCollectionName)
        
        docRefForCard
            .order(by: K.FStore.countFieldKey, descending: true)
            .addSnapshotListener { snapshot, error in
                guard let snapshot = snapshot, error == nil else {
                    print("Error fetching cards list: \(String(describing: error))")
                    completion(nil)
                    return
                }
                
                let documents = snapshot.documents
                if !documents.isEmpty {
                    let result: [Card] = documents.filter { doc in
                        doc.documentID != K.FStore.totalDocumentName
                    }.map { doc in
                        let data = doc.data()
                        
                        return Card(imageUri: data[K.FStore.imageUriFieldKey] as? String ?? "N/A",
                                    collectionId: data[K.FStore.collectionIdFieldKey] as! String,
                                    tokenId: data[K.FStore.tokenIdFieldKey] as! String,
                                    count: data[K.FStore.countFieldKey] as! Int64)
                    }
 
                    completion(result)
                    return
                } else {
                    completion(nil)
                }
            }
    }
  
}
