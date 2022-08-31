//
//  SearchBlogAPI.swift
//  SearchDaumBlog
//
//  Created by 김수빈 on 2022/09/01.
//

import Foundation

// request url setting
struct SearchBlogAPI {
    static let scheme = "https"
    static let host = "dapi.kakao.com"
    static let path = "/v2/search/"
    
    func searchBlog(query: String) -> URLComponents{
        var components = URLComponents()
        components.scheme = SearchBlogAPI.scheme
        components.host = SearchBlogAPI.host
        components.path = SearchBlogAPI.path
        
        components.queryItems = [
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "size", value: "25")
        ]
        
        return components
    }
}
