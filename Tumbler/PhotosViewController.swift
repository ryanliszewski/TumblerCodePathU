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
    tableView.delegate = self
    tableView.dataSource = self
    tableView.rowHeight = 200.0
    tableView.sectionHeaderHeight = 50.0
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
extension PhotosViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    print(posts.count)
    return posts.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
    let post = posts[indexPath.section]
    let photos = post["photos"] as? [[String: Any]]
    
    let photo = photos![0]
    let originalSize = photo["original_size"] as! [String:Any]
    let urlString = originalSize["url"] as! String
    let url = URL(string: urlString)
    cell.posterView.af_setImage(withURL: url!)
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let headerView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
    headerView.backgroundColor = UIColor(white: 1, alpha: 0.9)
    
    let profileView = UIImageView(frame: CGRect(x: 10, y: 10, width: 30, height: 30))
    profileView.clipsToBounds = true
    profileView.layer.cornerRadius = 15.0
    profileView.layer.borderColor = UIColor(white: 0.7, alpha: 0.8).cgColor
    profileView.layer.borderWidth = 1.0
    
    profileView.af_setImage(withURL: URL(string: "https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/avatar")!)
    
    print("test")
    
    let dateLabel = UILabel(frame: CGRect(x: 50, y: 10, width: 200, height: 30))
    let post = posts[section]
    let date = post["date"] as? String
    
    dateLabel.text = date
    
    headerView.addSubview(profileView)
    headerView.addSubview(dateLabel)
    return headerView
  }
}


//MARK: - Navigation
extension PhotosViewController {
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let detailViewController = segue.destination as! DetailViewController
    
    let cell = sender as! PhotoCell
    detailViewController.image = cell.posterView.image
  }
}
