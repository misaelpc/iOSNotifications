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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    messagesStore.fetchMessagesFromJson()
    setupTableViewCell()
    // Do any additional setup after loading the view, typically from a nib.
  }

  func setupTableViewCell() {
    self.tableView.register(UINib(nibName: "MessagesTableViewCell",
                                  bundle: nil), forCellReuseIdentifier: "MessagesTableViewCell")
    self.tableView.estimatedRowHeight = 80
  }
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
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

