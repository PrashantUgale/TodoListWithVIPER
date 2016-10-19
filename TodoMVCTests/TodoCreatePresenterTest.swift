//
//  TodoCreatePresenterTest.swift
//  TodoMVC
//
//  Created by Prashant Ugale on 10/18/16.
//  Copyright © 2016 GoJek. All rights reserved.
//

import Foundation
import Quick
import Nimble
import MockFive

@testable import TodoMVC

class CreateTodoViewMock: ICreateTodoView, Mock {
    
    let mockFiveLock: String = lock()
    
    func showAlertWithMessage(message: String) {
        return stub(identifier: "showAlertWithMessage", arguments: message, returns: { _ in
        })
    }
    
    func startLoading() {
        return stub(identifier: "startLoading", returns: { _ in
        })
    }
    
    func stopLoading() {
        return stub(identifier: "stopLoading", returns: { _ in
        })
    }
}


class WireframeMock: ITodoWireframe, Mock {
    
    let mockFiveLock: String = lock()
    
    func goBack() {
        return stub(identifier: "goBack", returns: { _ in
        })
    }
}


class NetworkManagerMock: INetworkManager, Mock {
    
    let mockFiveLock: String = lock()
    
    func addNewToDo(note: String, onCompletionSuccess: (response: AnyObject?) -> Void, onCompletionFailure: (error: String?) -> Void) {
        
        return stub(identifier: "addNewTodo", arguments: (note, onCompletionSuccess, onCompletionFailure), returns: { _ in
        })
    }
}

class TodoCreatePresenterTest: QuickSpec {
    
    override func spec() {
        describe("Add Todo Dote") {
            it("Add empty note") {
                let todoViewMock = CreateTodoViewMock()
                let wireframeMock = WireframeMock()
                let networkManagerMock = NetworkManagerMock()
                
                let presenter = TodoCreatePresenter(view: todoViewMock, wireframe: wireframeMock, service: networkManagerMock)
                
                presenter.addToDo("")
                expect(todoViewMock.invocations).to(contain("showAlertWithMessage(Please enter the todo description)"))
                
            }
            
            it("Add valid todo") {
                let todoViewMock = CreateTodoViewMock()
                let wireframeMock = WireframeMock()
                let networkManagerMock = NetworkManagerMock()

                networkManagerMock.registerStub("addNewTodo", returns: { args -> Void in
                    let (_, success, _) = args[0] as! (String, (AnyObject?) -> Void, (String?) -> Void)
                    success(nil)
//                    message
//                    failure("failed")
                })
                
                let presenter = TodoCreatePresenter(view: todoViewMock, wireframe: wireframeMock, service: networkManagerMock)
                
                presenter.addToDo("This is my test note")
                expect(todoViewMock.invocations).to(contain("startLoading()"))
                expect(todoViewMock.invocations).to(contain("stopLoading()"))
                expect(wireframeMock.invocations).to(contain("goBack()"))
            }
        }
    }
    
}
