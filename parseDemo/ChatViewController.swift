//
//  ChatViewController.swift
//  parseDemo
//
//  Created by LING HAO on 4/12/17.
//  Copyright © 2017 CodePath. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var chatArray: [PFObject] = []
    @IBOutlet var chatText: UITextField!
    
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(onTimer), userInfo: nil, repeats: true)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        let object = chatArray[indexPath.row]
        cell?.textLabel?.text = object["text"] as! String?
        return cell!
    }
    
    func onTimer() {
        let query = PFQuery(className: "Message")
        query.order(byDescending: "createdAt")
        query.findObjectsInBackground { (objects, error) in
            if error == nil {
                if let objects = objects {
                    for object in objects {
                        self.chatArray.append(object)
                        print(object)
                    }
                }
                self.tableView.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func buttonClicked(_ sender: Any) {
        let chat = PFObject(className: "Message")
        chat["text"] = chatText.text
        chat.saveInBackground { (success: Bool, error: Error?) in
            if success {
                print("chat save succeeded")
            } else {
                print("error \(error)")
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
