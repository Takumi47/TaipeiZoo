//
//  JsonManager.swift
//  TaipeiZoo
//
//  Created by alex on 05/09/2017.
//  Copyright © 2017 alex. All rights reserved.
//

import UIKit

class JsonManager: NSObject {

    // MARK: - Properties
    
    private static let instance = JsonManager()
    static var sharedInstance: JsonManager { return instance }
    
    enum HTTPMethod: String {
        case get = "GET", post = "POST"
    }
    
    // MARK: - Public API
    
    func getJsonObject(method: HTTPMethod, url: URL, body: Data? = nil, timeout second: Double = 15, finish: ((_ object: Any?) -> ())?) {
        var request = URLRequest(
            url: url,
            cachePolicy: URLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData,
            timeoutInterval: second)
        request.httpMethod = method.rawValue
        request.httpBody = body
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // 取得資料失敗
            if let error = error {
                print(error)
                finish?(nil)
                return
            }
            guard let data = data else {
                finish?(nil)
                return
            }
            
            // 取得資料成功
            do {
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                finish?(jsonObject)
            } catch {
                print(error)
                finish?(nil)
            }
        }
        task.resume()
    }
    
    func getImageData(method: HTTPMethod, url: URL, body: Data? = nil, timeout second: Double = 30, finish: ((_ object: Any?) -> ())?) {
        var request = URLRequest(
            url: url,
            cachePolicy: URLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData,
            timeoutInterval: second)
        request.httpMethod = method.rawValue
        request.httpBody = body
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // 取得資料失敗
            if let error = error {
                print(error)
                finish?(nil)
                return
            }
            guard let data = data else {
                finish?(nil)
                return
            }
            
            // 取得資料成功
            if let image = UIImage(data: data) {
                finish?(image)
            } else {
                finish?(nil)
            }
        }
        task.resume()
    }

}
