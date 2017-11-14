//
//  PhotosViewController.swift
//  Tumbler
//
//  Created by Ryan Liszewski on 11/11/17.
//  Copyright © 2017 ImThere. All rights reserved.
//

import UIKit
import AlamofireImage

class PhotosViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  
  var posts: [[String: Any]] = [] {
    didSet {
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    initializeTableView()
    tumblrApiRequest()
  }
}

//MARK: - Helper Functions
extension PhotosViewController {
  
  private func initializeTableView(){
    tableView.dataSource = self
    tableView.dataSource = self
    tableView.rowHeight = 200.0
  }
  
  private func tumblrApiRequest(){
    let url = URL(string: "https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV")!
    let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
    session.configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
    let task = session.dataTask(with: url) { (data, response, error) in
      if let error = error {
        print(error.localizedDescription)
      } else if let data = data,
        let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
        let responseDictionary = dataDictionary["response"] as! [String: Any]
        self.posts = responseDictionary["posts"] as! [[String: Any]]
      }
    }
    task.resume()
  }
}

//MARK: - UITableViewDataSource
extension PhotosViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return posts.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    print("test")
    let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
    let post = posts[indexPath.row]
    let photos = post["photos"] as? [[String: Any]]
    
    let photo = photos![0]
    let originalSize = photo["original_size"] as! [String:Any]
    let urlString = originalSize["url"] as! String
    let url = URL(string: urlString)
    cell.posterView.af_setImage(withURL: url!)
    return cell
  }
}
