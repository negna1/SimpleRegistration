//
//  IconsRequest.swift
//  PetProject
//
//  Created by Nato Egnatashvili on 15.02.23.
//

import CombineCore
import Foundation

var APIKEY = "33674973-15cb5387dd8098b18a6c2b917"

extension URLComponents {
    static func icons(queryItems: [URLQueryItem]) -> Self {
        Self(host: "pixabay.com",
            path: "/api/",
        queryItems: queryItems)

    }
}
//https://pixabay.com/api/?key=33674973-15cb5387dd8098b18a6c2b917&q=yellow+flowers&image_type=photo&pretty=true

extension URLRequest {
    static func icons(body: IconRequest) -> Self {
        Self(components: .icons(queryItems: body.queryItems))
            .add(httpMethodType: .GET)
    }
}

struct IconRequest: Bodyable {
    var toBody: [String : Any] = [:]
    var queryItems: [URLQueryItem] = []
    let key: String 
    let q: String
    let image_type: String
    
    public init(key: String = APIKEY,
                q: String = "yellow flowers",
                image_type: String = "image_type") {
        self.key = key
        self.q = q
        self.image_type = image_type
        
        self.queryItems = [.init(name: "key", value: key),
                           .init(name: "q", value: q),
                           .init(name: "image_type", value: image_type)]
        self.toBody =  ["key": key,
                        "q": q,
                        "image_type": image_type]
    }
}
