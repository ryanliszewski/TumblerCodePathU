//
//  FullScreenPhotoViewController.swift
//  Tumbler
//
//  Created by Samman Thapa on 11/18/17.
//  Copyright © 2017 ImThere. All rights reserved.
//

import UIKit

class FullScreenPhotoViewController: UIViewController {
    
    var fullScreenImage: UIImage!
    
    @IBOutlet weak var fullScreenImageView: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.fullScreenImageView.image = self.fullScreenImage
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        print ("Came here")
        print (self.fullScreenImage)
        self.fullScreenImageView.image = self.fullScreenImage
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCloseTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
