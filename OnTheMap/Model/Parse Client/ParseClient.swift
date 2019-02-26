//
//  ParseClient.swift
//  OnTheMap
//
//  Created by SDK on 2/12/19.
//  Copyright © 2019 SDK. All rights reserved.
//

import Foundation

class ParseClient {
    
    static let appId = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
    static let apiKey = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
    
    class func getStudentLocation(completion: @escaping ([StudentLocation], Error?) -> Void) {
        taskForGETRequest(url: Endpoints.getStudentLocation.url, responseType: LocationResult.self) { response, error in
            if let response = response {
                completion(response.results, nil)
            } else {
                completion([], error)
            }
        }
    }
    
    class func postStudentLocation(body: StudentLocation, completion: @escaping (Bool, Error?) -> Void) {
        taskForPOSTRequest(url: Endpoints.postStudentLocation.url, responseType: PostStudentResponse.self, body: body) { response, error in
            if response != nil {
                completion(true, nil)
            } else {
                completion(false, error)
            }
        }
    }
    
    // MARK: - HTTP Methods
    
    class func taskForGETRequest<ResponseType: Decodable>(url: URL,
                                                          responseType: ResponseType.Type,
                                                          completion: @escaping (ResponseType?, Error?) -> Void) {
        var request = URLRequest(url: url)
        request.addValue(ParseClient.appId, forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue(ParseClient.apiKey, forHTTPHeaderField: "X-Parse-REST-API-Key")

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
                        
            let decoder = JSONDecoder()
            
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }
        
        task.resume()
    }
    
    class func taskForPOSTRequest<RequestType: Encodable, ResponseType: Decodable>(url: URL,
                                                                                   responseType: ResponseType.Type,
                                                                                   body: RequestType,
                                                                                   completion: @escaping (ResponseType?, Error?) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try! JSONEncoder().encode(body)
        request.addValue(ParseClient.appId, forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue(ParseClient.apiKey, forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            let newData = data.subdata(in: 5..<data.count)
            
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: newData)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                do {
                    let errorObject = try decoder.decode(ErrorResponse.self, from: newData) as Error
                    DispatchQueue.main.async {
                        completion(nil, errorObject)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            }
        }
        
        task.resume()
    }
}
