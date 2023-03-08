//
//  KlaytnNftRequester.swift
//  mship__sample__klip_nft
//
//  Created by Hank on 2023/01/25.
//

import Foundation

class KlaytnNftRequester {
    private static let TOKEN_URL__GET_NFTS_BY_OWNER_ADDRESS__PARAMS_2 = "https://th-api.klaytnapi.com/v2/contract/nft/%@/owner/%@"
    private static let TOKEN_HEADER__KEY__CHAIN_ID = "x-chain-id"
    private static let TOKEN_HEADER__VALUE__CHAIN_ID = "8217"
    private static let TOKEN_HEADER__KEY__AUTHORIZATION = "Authorization"
    private static let TOKEN_HEADER__VALUE__AUTHORIZATION = "Basic S0FTSzEyQ1JKNTNZTk9GQkUwMzM0TUJFOkwwUUpYTHJNam43cUNDWXVJUG05OWZ5Rko5MnJtNjRlaWxGMTJwdkQ="
    private static let TOKEN_PARAMS__KEY__SIZE = "size"
    private static let TOKEN_PARAMS__VALUE__SIZE_MAX = "1000"
    private static let CONTRACT_ADDRESS__BELLY_GOM = "0xce70eef5adac126c37c8bc0c1228d48b70066d03"
    
    // MARK: Commons
    public static func requestSimple(
        urlToken: String,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> Bool {
        let urlSession = URLSession(configuration: .default)
        
        guard let url = URL(string: urlToken) else {
            let errorMessage = "Url is nil : urlToken: \(urlToken)."
            completionHandler(nil, nil, NSError(domain: errorMessage, code: -1))
            LLog.w(errorMessage)
            return false
        }
        
        let dataTask = urlSession.dataTask(with: url, completionHandler: completionHandler)
        dataTask.resume()
        return true
    }
    
    public static func processResponse(data: Data?, response: URLResponse?, error: Error?) -> Bool {
        guard error == nil else {
            LLog.w("error: \(String(describing: error)).")
            return false
        }
        
        guard let _ = data,
              let response = response as? HTTPURLResponse,
              response.statusCode == 200 else {
            LLog.w("Invalid result : data: \(String(describing: data)), response: \(String(describing: response)).")
            return false
        }
        return true
    }
    
    public static func convertTo<T>(type: T.Type, data: Data) -> T? where T: Decodable {
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            LLog.w("error: \(error), type: \(type).")
            return nil
        }
    }
    
    public static func convertToJson(data: Data, showLog: Bool = false) -> Any? {
        guard let jsonData = try? JSONSerialization.jsonObject(with: data) else {
            LLog.w("Json-serializing is failed.")
            return nil
        }
        
        if showLog {
            LLog.i("jsonData: \(jsonData).")
        }
        return jsonData
    }
    
    // MARK: Get Nfts
    public static func requestToGetNfts(
        contractAddress: String,
        walletAddress: String,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> Bool {
        let urlSession = URLSession(configuration: .default)
        let urlToken = String(format: KlaytnNftRequester.TOKEN_URL__GET_NFTS_BY_OWNER_ADDRESS__PARAMS_2, contractAddress, walletAddress)
        var urlComponents = URLComponents(string: urlToken)
        urlComponents?.queryItems = [URLQueryItem(name: TOKEN_PARAMS__KEY__SIZE, value: TOKEN_PARAMS__VALUE__SIZE_MAX)]
        
        guard var url = urlComponents?.url else {
            let errorMessage = "Url is nil : urlToken: \(urlToken), contractAddress: \(contractAddress), walletAddress: \(walletAddress)."
            completionHandler(nil, nil, NSError(domain: errorMessage, code: -1))
            LLog.w(errorMessage)
            return false
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue(
            KlaytnNftRequester.TOKEN_HEADER__VALUE__CHAIN_ID,
            forHTTPHeaderField: KlaytnNftRequester.TOKEN_HEADER__KEY__CHAIN_ID
        )
        urlRequest.addValue(
            KlaytnNftRequester.TOKEN_HEADER__VALUE__AUTHORIZATION,
            forHTTPHeaderField: KlaytnNftRequester.TOKEN_HEADER__KEY__AUTHORIZATION
        )
        
        let dataTask = urlSession.dataTask(with: urlRequest, completionHandler: completionHandler)
        dataTask.resume()
        return true
    }
    
    public static func requestToGetNfts(
        contractAddress: String,
        walletAddress: String,
        nftsHandler: @escaping (KlaytnNfts?, Error?) -> Void
    ) -> Bool {
        return requestToGetNfts(contractAddress: contractAddress, walletAddress: walletAddress) { data, response, error in
            let result = KlaytnNftRequester.processResponse(data: data, response: response, error: error)
            guard let data = data, result else {
                let errorMessage = "Invalid result : contractAddress: \(contractAddress), walletAddress: \(walletAddress)."
                nftsHandler(nil, NSError(domain: errorMessage, code: -1))
                LLog.w(errorMessage)
                return
            }
            
            guard let nfts = convertTo(type: KlaytnNfts.self, data: data) else {
                let errorMessage = "Converting result data is failed : contractAddress: \(contractAddress), walletAddress: \(walletAddress)."
                nftsHandler(nil, NSError(domain: errorMessage, code: -1))
                LLog.w(errorMessage)
                return
            }
            
            nftsHandler(nfts, nil)
        }
    }
    
    // MARK: for BellyGom
    public static func requestToGetBellyGomNfts(
        walletAddress: String,
        nftsHandler: @escaping ([BellyGomNft]) -> Void
    ) -> Bool {
        return requestToGetNfts(
            contractAddress: KlaytnNftRequester.CONTRACT_ADDRESS__BELLY_GOM,
            walletAddress: walletAddress
        ) { nfts, error in
            guard let rawNfts = nfts else {
                LLog.w("rawNfts is nil : error: \(String(describing: error)).")
                return
            }
            
            requestToGetBellyGomNfts(rawNfts: rawNfts) { bellyGomNfts in
                return nftsHandler(bellyGomNfts)
            }
        }
    }
    
    public static func requestToGetBellyGomNfts(
        rawNfts: KlaytnNfts,
        nftsHandler: @escaping ([BellyGomNft]) -> Void
    ) {
        var bellyGomNfts: [BellyGomNft] = []
        var taskCount = rawNfts.items.count
        
        let taskLock = NSRecursiveLock()
        let dispatchQueue = DispatchQueue.global(qos: .utility)
        
        func discountTaskSafely() {
            taskLock.lock()
            taskCount -= 1
            taskLock.unlock()
        }
        
        rawNfts.items.forEach { rawItem in
            _ = requestSimple(urlToken: rawItem.tokenUri) { data, response, error in
                dispatchQueue.async {
                    guard processResponse(data: data, response: response, error: error),
                          let data = data else {
                        discountTaskSafely()
                        LLog.w("Invalid result.")
                        return
                    }
                    
                    guard let metadata = convertTo(type: BellyGomNftMetadata.self, data: data) else {
                        discountTaskSafely()
                        LLog.w("metadata is nil.")
                        return
                    }
                    
                    taskLock.lock()
                    bellyGomNfts.append(createBellyGomNft(rawNft: rawItem, metadata: metadata))
                    discountTaskSafely()
                    taskLock.unlock()
                }
            }
        }
        
        while true {
            taskLock.lock()
            if taskCount == 0 {
                break
            }
            taskLock.unlock()
        }
        
        nftsHandler(bellyGomNfts)
        taskLock.unlock()
    }
    
    private static func createBellyGomNft(rawNft: KlaytnNft, metadata: BellyGomNftMetadata) -> BellyGomNft {
        return BellyGomNft(
            name: metadata.name,
            description: metadata.description,
            imageUrl: metadata.image,
            score: metadata.score,
            tokenId: rawNft.tokenId,
            updateAt: rawNft.updatedAt,
            previousOwnerAddress: rawNft.previousOwner,
            traits: createBellyGomNftTraits(metadata: metadata)
        )
    }
    
    private static func createBellyGomNftTraits(metadata: BellyGomNftMetadata) -> BellyGomNft.Traits {
        var attributeMap: [String:Any] = [:]
        attributeMap = metadata.attributes
            .reduce(into: attributeMap) { result, attribute in
                result[attribute.trait_type] = attribute.value
            }
        
        // We expect a error with app-crash if wrong key-value exists.
        return BellyGomNft.Traits(
            background: attributeMap[BellyGomNft.TraitType.background_string.rawValue] as! String,
            body: attributeMap[BellyGomNft.TraitType.body_string.rawValue] as! String,
            clothes: attributeMap[BellyGomNft.TraitType.clothes_string.rawValue] as! String,
            head: attributeMap[BellyGomNft.TraitType.head_string.rawValue] as! String,
            acc: attributeMap[BellyGomNft.TraitType.acc_string.rawValue] as! String,
            special: attributeMap[BellyGomNft.TraitType.special_string.rawValue] as! String,
            rank: attributeMap[BellyGomNft.TraitType.rank_int.rawValue] as! Int,
            grade: BellyGomNft.GradeType(rawValue: attributeMap[BellyGomNft.TraitType.grade_gradeType.rawValue] as! String)!
        )
    }
}
