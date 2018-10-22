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
    
    override func viewDidLoad() {
        super.viewDidLoad();
        print("Id: \(String(describing: id))");
        print("Name: \(String(describing: name))");
        print("Email: \(String(describing: email))");
        print("Correction Points: \(String(describing: correction_point))");
        print("Image: \(String(describing: ProfileViewController.realImageUrl))");
        print("Phone: \(String(describing: phone))");
        print("Cohort: \(String(describing: pool_year))");
        print("Wallet: \(String(describing: wallet))");
        print("Login: \(String(describing: login))");
        
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
            downloadImage(from: url)
        }
    }

    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }

    func downloadImage(from url: URL)
    {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                self.imageView.image = UIImage(data: data)
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



}
