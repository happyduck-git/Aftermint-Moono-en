//
//  FirebaseStorageService.swift
//  mojitok-nft
//
//  Created by GAMZA on 2022/03/17.
//

import Foundation

import FirebaseStorage

final class FirebaseStorageService {

    static let shared = FirebaseStorageService()

    private let queue = DispatchQueue(label: "StorageService", attributes: .concurrent)
    private let storage: StorageReference

    private init() {
        self.storage = Storage.storage().reference()
    }

    func getFile(urlString: String, completion: @escaping (Data?) -> Void) {
        let gsReferecnce = storage.child(urlString)

        queue.async {
            gsReferecnce.getData(maxSize: 1024 * 1024 * 4) { (data, error) in
                if let error = error  {
                    print("Download template from Stoarge")
                    dump(error)
                }
                completion(data)
            }
        }
    }
}
