//
//  NetworkManager.swift
//  TodoMVC
//
//  Created by Prashant Ugale on 10/18/16.
//  Copyright © 2016 GoJek. All rights reserved.
//

import Foundation
import Alamofire

protocol INetworkManager {
    func addNewToDo(note: String, onCompletionSuccess:(response:AnyObject?) -> Void, onCompletionFailure: (error: String?) -> Void)
}

class NetworkManager: INetworkManager {

    func addNewToDo(note: String, onCompletionSuccess: (response: AnyObject?) -> Void, onCompletionFailure: (error: String?) -> Void) {
        var message:String?
        
        let url = BASE_URL + "/todos/create"
        Alamofire.request(.POST, url, parameters: ["description" : note], headers: AuthManager.sharedManager.authHeaders).responseString { response in
            
            guard let jsonString = response.result.value else {
                message = response.result.error?.localizedDescription ?? ""
                onCompletionFailure(error: message)
                return
            }
            let createResponse = CreateTodoResponse(JSONString: jsonString)
            guard let _ = createResponse?.todo where createResponse?.error == nil else {
                onCompletionFailure(error: message)
                return
            }
            onCompletionSuccess(response: nil)
    }
    }
}