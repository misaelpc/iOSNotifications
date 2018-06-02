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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    messagesStore.fetchMessagesFromJson()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

