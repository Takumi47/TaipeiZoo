//
//  AnimalModel.swift
//  TaipeiZoo
//
//  Created by alex on 05/09/2017.
//  Copyright © 2017 alex. All rights reserved.
//

import UIKit

class AnimalModel: NSObject {

    struct Info {
        var _id: String?         // id
        var A_Name_Ch: String?   // 中文名
        var A_Keywords: String?  // 關鍵字
        var A_Pic01_ALT: String? // 照片說明
        var A_Pic01_URL: String? // 照片URL
    }
    
    var results: [Info]?
    
    func setData(jsonObject: Any?) {
        guard let jsonObject = jsonObject as? [String : Any] else { return }
        guard let jsonInfos = jsonObject["result"] as? [String : Any] else { return }
        guard let animalInfos = jsonInfos["results"] as? [[String : String]] else { return }
        
        results = animalInfos.map { result -> Info in
            return Info(
                _id: result["_id"] ?? "",
                A_Name_Ch: result["A_Name_Ch"] ?? "",
                A_Keywords: result["A_Keywords"] ?? "",
                A_Pic01_ALT: result["A_Pic01_ALT"] ?? "",
                A_Pic01_URL: result["A_Pic01_URL"] ?? "")
        }
    }
    
}
