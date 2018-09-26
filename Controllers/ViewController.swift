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
    setupScrollNotifications()
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  func setupTableViewCell() {
    self.tableView.register(UINib(nibName: "MessagesTableViewCell",
                                  bundle: nil), forCellReuseIdentifier: "MessagesTableViewCell")
    self.tableView.estimatedRowHeight = 80
  }
  
  func setupKeyboardNotifications() {
    NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
    
    NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillHideNotification, object: nil)
  }
  
  func setupScrollNotifications() {
    NotificationCenter.default.addObserver(self, selector: #selector(handleScrollNotification), name: NSNotification.Name(rawValue: "com.bunsan.didScroll"), object: nil)
  }
  
  @objc func handleScrollNotification(notification: NSNotification) {
    messageInputTextField.resignFirstResponder()
  }
  
  
  @objc func handleKeyboardNotification(notification: NSNotification) {
    guard let userInfo = notification.userInfo else {return}
    let keyBoardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
    
    if notification.name == UIResponder.keyboardWillShowNotification {
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
    let message = messagesStore.messages[indexPath.row]
    let cell = tableView.dequeueReusableCell(withIdentifier: "MessagesTableViewCell", for: indexPath) as? MessagesTableViewCell
    cell?.textView.text = message.content
    return cell!
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
  
  func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    NotificationCenter.default.post(name: Notification.Name(rawValue: "com.bunsan.didScroll"), object: self)
  }
}

