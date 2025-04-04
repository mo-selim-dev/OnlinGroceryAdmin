//
//  ServiceCall.swift
//  OnlinGroceryStore
//
//  Created by Mohamed Selim on 16/01/2025.
//

import SwiftUI

class ServiceCall {
    
    class func post(parameter: NSDictionary, path: String, isToken: Bool = false, withSuccess: @escaping ( (_ responseObj: AnyObject?) ->() ), failure: @escaping ( (_ error: Error?) ->() ) ) {
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            let parameterData = NSMutableData()
            let dictKey = parameter.allKeys as! [String]
            
            var i=0;
            
            for dictKey in dictKey {
                if let values = parameter.value(forKey: dictKey) as? String{
                    parameterData.append(String.init(format: "%@%@=%@", i==0 ? "" : "&" ,dictKey, values.replacingOccurrences(of: "+", with: "%2B")).data(using: String.Encoding.utf8)!)
                }else{
                    parameterData.append(String.init(format: "%@%@=%@", i==0 ? "" : "&" ,dictKey, parameter.value(forKey: dictKey) as! CVarArg) .data(using: String.Encoding.utf8)!)
                }
                
                i += 1
            }
            
            
            var request = URLRequest(url: URL(string: path)!,timeoutInterval: 20)
            request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

            if(isToken) {
                
//                #if DEBUG
//                request.addValue( "vJ2uhEIQ0VxbsgdSX8ZZ", forHTTPHeaderField: "access_token")
//                #else
//                request.addValue( MainViewModel.shared.userObj.authToken, forHTTPHeaderField: "access_token")
//                #endif
                request.addValue( MainViewModel.shared.userObj.authToken, forHTTPHeaderField: "access_token")

            }
            
            request.httpMethod = "POST"
            request.httpBody = parameterData as Data

            let task = URLSession.shared.dataTask(with: request) { data, response, error in
              
                if let error = error {
                    DispatchQueue.main.async {
                        failure(error)
                    }
                }else{
                    
                    if let data = data {
                        do {
                            let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary
                            
                            debugPrint("response: " , jsonDictionary as Any )
                            
                            DispatchQueue.main.async {
                                withSuccess(jsonDictionary)
                            }
                            
                            
                        }
                        catch {
                            DispatchQueue.main.async {
                                failure(error)
                            }
                        }
                    }
                   
                
                }
                
              guard let data = data else {
                
                return
              }
              
            }

            task.resume()
            
            
            
            
        }
        
    }
    
    
    
    class func multipart(parameter: NSDictionary, path: String, imageDic: NSDictionary?, isToken: Bool = false, isUIImageKey: Bool =  false,  withSuccess: @escaping ( (_ responseObj: AnyObject?) -> () ), failure: @escaping ( (_ error: Error?) -> () ) ) {
            
            DispatchQueue.global(qos: .userInitiated).async {
                
                let boundary = "----WebKitFormBoundary7MA4YWxkTrZu0gW"
                var headers = [
                    "content-type": "multipart/form-data; boundary=\(boundary)",
                    "cache-control": "no-cache",
                ]
                
                if(isToken) {
                    
                   
                    
                    headers["access_token"] = MainViewModel.shared.userObj.authToken
                }
                
                let request = NSMutableURLRequest(url:  NSURL(string: path)! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 500.0 )
                request.httpMethod = "POST"
                request.allHTTPHeaderFields  = headers
                
                let body = NSMutableData()
                for (key, value) in parameter {
                    body.appendString(string: "--\(boundary)\r\n")
                    body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                    body.appendString(string: "\(value)\r\n")
                }
                
                
                for (key, value) in imageDic ?? [:] {
                    let filename = "\(UUID().uuidString).jpg"
                    let mimetype = "image/jpg"
                    body.appendString(string: "--\(boundary)\r\n")
                    body.appendString(string: "Content-Disposition: form-data; name=\"\( isUIImageKey ? value  : key)\"; filename=\"\(filename)\"\r\n")
                    body.appendString(string: "Content-Type:\(mimetype)\r\n\r\n")
                    body.append( ( ( isUIImageKey ? key : value) as! UIImage).jpegData(compressionQuality: 0.7)! )
                    body.appendString(string: "\r\n")
                    
                }
                
                body.appendString(string: "--\(boundary)--\r\n")
                request.httpBody = body as Data
                
                let datastring = NSString(data: body as Data, encoding: String.Encoding.utf8.rawValue)
                debugPrint(datastring as Any)
                
                let session = URLSession.shared
                let dataTask = session.dataTask(with: request as URLRequest) { data, response, error in
                    
                    if let error = error {
                        DispatchQueue.main.async {
                            failure(error)
                        }
                    }else {
                        if let data = data {
                            do {
                                let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary
                                debugPrint("response: ", jsonDictionary )
                                
                                DispatchQueue.main.async {
                                    withSuccess(jsonDictionary)
                                }
                            }
                            catch {
                                DispatchQueue.main.async {
                                    failure(error)
                                }
                            }
                        }
                        
                        
                    }
                    
                    guard let data = data else {
                        return
                    }
                    
                }
                
                dataTask.resume()
            }
        }
    

    
}

extension NSMutableData {
    
    func appendString(string: String) {
        append( string.data(using: .utf8, allowLossyConversion: true)!)
    }
}


    
