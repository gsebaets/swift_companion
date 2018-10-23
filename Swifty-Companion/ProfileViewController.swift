//
//  ProfileViewController.swift
//  Swifty-Companion
//
//  Created by Kuzivakwashe MUVEZWA on 2018/10/16.
//  Copyright © 2018 Kuzivakwashe MUVEZWA. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController
{


    static var realImageUrl:String?
    
    //Profile info Label
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var correctionLabel: UILabel!
    @IBOutlet weak var walletLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad();
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "back")!)
        
        nameLabel.text = name
        emailLabel.text = email
        userNameLabel.text = login
        phoneLabel.text = "Phone: " + phone
        yearLabel.text = pool_year
        walletLabel.text = "Wallet: $ " + wallet
        correctionLabel.text = "Correction Points: " + correction_point
        
        if let url = URL(string: ProfileViewController.realImageUrl!)
        {
            imageView.contentMode = .scaleAspectFit
            imageView.layer.borderWidth = 1
            imageView.layer.masksToBounds = false
            imageView.layer.borderColor = UIColor.blue.cgColor
            imageView.layer.cornerRadius = imageView.frame.width/2
            imageView.clipsToBounds = true
            downloadImage(from: url)
        }
    }

    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ())
    {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }

    func downloadImage(from url: URL)
    {
        print("Download Started")
        getData(from: url)
        {
            (data, response, error) in
            if error != nil
            {
                return
            }
            if (data != nil)
            {
                print("Download Finished")
                DispatchQueue.main.async()
                {
                    self.imageView.image = UIImage(data: data!)
                }
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



}
