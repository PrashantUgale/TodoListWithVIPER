//
//  TodoCreatePresenter.swift
//  TodoMVC
//
//  Created by Prashant Ugale on 10/18/16.
//  Copyright © 2016 GoJek. All rights reserved.
//

import Foundation


protocol ITodoCreatePresenter {
    func addToDo(text: String?)
}

class TodoCreatePresenter: ITodoCreatePresenter {
    
    weak var todoView: ICreateTodoView?
    var wireframe: ITodoWireframe?
    var service: INetworkManager?
    
    init(view: ICreateTodoView?, wireframe: ITodoWireframe?, service: INetworkManager?) {
        self.todoView = view
        self.wireframe = wireframe
        self.service = service
    }
    
    func addToDo(text: String?) {
        guard let textValue = text where textValue.characters.count > 0 else {
            todoView?.showAlertWithMessage("Please enter the todo description")
            return
        }
        
        todoView?.startLoading()
        self.service?.addNewToDo(textValue, onCompletionSuccess: { [weak self] (response) in
            self?.todoView?.startLoading()
            self?.wireframe?.goBack()
            }, onCompletionFailure: { [weak self] (message) in
                self?.todoView?.stopLoading()
                self?.todoView?.showAlertWithMessage(message ?? "Error")
            })
    }
}
