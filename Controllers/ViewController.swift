//
//  ViewController.swift
//  BunsanMessenger
//
//  Created by Misael Pérez Chamorro on 6/1/18.
//  Copyright © 2018 Misael Pérez Chamorro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  let messagesStore = MessagesStore.sharedInstance
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var textContainerView: UIView!
  @IBOutlet weak var bottomSpace: NSLayoutConstraint!
  @IBOutlet weak var messageInputTextField: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    messagesStore.fetchMessagesFromJson()
    setupTableViewCell()
    setupKeyboardNotifications()
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  func setupTableViewCell() {
    self.tableView.register(UINib(nibName: "MessagesTableViewCell",
                                  bundle: nil), forCellReuseIdentifier: "MessagesTableViewCell")
    self.tableView.estimatedRowHeight = 80
  }
  
  func setupKeyboardNotifications() {
    NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    
    NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
  }
  
  @objc func handleKeyboardNotification(notification: NSNotification) {
    guard let userInfo = notification.userInfo else {return}
    let keyBoardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
    
    if notification.name == NSNotification.Name.UIKeyboardWillShow {
      bottomSpace.constant = -(keyBoardFrame?.height)! + 40
    } else {
      bottomSpace.constant = 0
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func sendButtonWasTouchedUpInside(sender: Any) {
    messageInputTextField.text = ""
    messageInputTextField.resignFirstResponder()
  }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return messagesStore.messages.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "MessagesTableViewCell", for: indexPath) as? MessagesTableViewCell
    return cell!
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
  }
  
}

