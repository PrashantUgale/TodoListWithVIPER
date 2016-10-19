//
//  TodoWireframe.swift
//  TodoMVC
//
//  Created by Prashant Ugale on 10/18/16.
//  Copyright © 2016 GoJek. All rights reserved.
//

import Foundation
import UIKit

protocol ITodoWireframe {
    func goBack()
}

class TodoWireframe: ITodoWireframe {
    
    
    func goBack() {
        let controller = UIApplication.sharedApplication().delegate?.window??.rootViewController as? UINavigationController
        controller?.popViewControllerAnimated(true)
    }
}