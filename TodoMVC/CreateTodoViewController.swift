//
//  CreateTodoViewController.swift
//  TodoMVC
//
//  Created by Harshad on 11/10/16.
//  Copyright © 2016 GoJek. All rights reserved.
//

import UIKit
import Alamofire

protocol ICreateTodoView: class {
    func showAlertWithMessage(message: String)
    func startLoading()
    func stopLoading()
}

class CreateTodoViewController: UIViewController, ICreateTodoView {
    @IBOutlet weak var textField: UITextField?
    
    var wireframe: ITodoWireframe?
    var networkManager: INetworkManager?
    var todoPresenter: ITodoCreatePresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Todo"
        let doneButton = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(CreateTodoViewController.touchDone))
        navigationItem.rightBarButtonItem = doneButton
        
        wireframe = TodoWireframe()
        networkManager = NetworkManager()
        todoPresenter = TodoCreatePresenter(view: self, wireframe: wireframe, service: networkManager)
    }
    
    func touchDone() {
        addTodo()
    }
    
    func addTodo() {
        
        let todoText = textField?.text?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
        todoPresenter?.addToDo(todoText)
    }

}
