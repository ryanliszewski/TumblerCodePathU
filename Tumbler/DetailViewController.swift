//
//  DetailViewController.swift
//  Tumbler
//
//  Created by Ryan Liszewski on 11/18/17.
//  Copyright © 2017 ImThere. All rights reserved.
//

import UIKit
import AlamofireImage

class DetailViewController: UIViewController {
  
  
  @IBOutlet weak var posterImageView: UIImageView!
  var image: UIImage!
  override func viewDidLoad() {
        super.viewDidLoad()

    posterImageView.image = image
    
    /* all user interaction */
    posterImageView.isUserInteractionEnabled = true
    
    /* add taps */
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTap(sender:)))
    posterImageView.addGestureRecognizer(tapGestureRecognizer)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func didTap(sender: UITapGestureRecognizer) {
        let location = sender.location(in: view)
        // User tapped at the point above. Do something with that if you want.
        print ("ImageView: tapped once")
        
        /* trigger segue manually */
        self.performSegue(withIdentifier: "toFullScreenImageSegue", sender: nil)
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
