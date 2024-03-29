//
//  ViewController.swift
//  Swifty-Companion
//
//  Created by Kuzivakwashe MUVEZWA on 2018/10/16.
//  Copyright © 2018 Kuzivakwashe MUVEZWA. All rights reserved.
//

import UIKit
import SwiftyJSON

var Token : String = "";
var searchProfile:User? = nil;
var name = "";
var id = "";
var email = "";
var correction_point = "";
var image_url = "";
var phone = "";
var pool_year = "";
var wallet = "";
var skills:[skill] = [];
var projects:[project] = [];
var login = "";
var expirationDate: Date?

struct project
{
    var id: Int;
    var name: String;
    var final_mark: Int;
}

struct skill
{
    var id : Int;
    var name: String;
    var level: Int;
}

class ViewController: UIViewController
{

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var searchBtn: UIButton!
    
    @IBAction func SearchForStudentButton(_ sender: UIButton)
    {
        print("Start Search");
        clearUser();
        if(userNameTextField.text != "")
        {
            print("User: \(String(describing: userNameTextField.text))")
            getUser(user: userNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines))
        }
        else
        {
            let alert = UIAlertController(title: "Error Empty Field!", message: "You shall not pass!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad();
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "back")!)
        searchBtn.layer.cornerRadius = 5
        // Do any additional setup after loading the view, typically from a nib.
        appLogin();
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func appLogin()
    {
        print("Authorising!");
        let authEndPoint: String = "https://api.intra.42.fr/oauth/token"
        let url = URL(string: authEndPoint)
        var request = URLRequest(url: url!)
        
        request.httpMethod = "POST"
        
        request.httpBody =     "grant_type=client_credentials&client_id=fe6b5d1013c7372cb4f5f2184d1fea5f80241b0a38f011b243092ffbacb73a35&client_secret=d175f1ca71a908b07742eec622198c2ae6a1dcda494b04bdeaec62ad19af1103".data(using: String.Encoding.utf8)
        
        let session = URLSession.shared
       
        session.dataTask(with: request)
        {
            (data, response, error) in
            if let data = data
            {
                do
                {
                    let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject]
                    print(dictionary!)
                    if let tempToken = dictionary
                    {
                        expirationDate = Date(timeIntervalSinceNow: 7200 + (tempToken["expires_in"] as! Double))
                        print(expirationDate!)
                        Token = (tempToken["access_token"] as! String)
                        print("Token: \(String(describing: Token))\n\n\n")
                    }
                    
                }
                catch let error
                {
                    print(error)
                }
            }
        }.resume()
    }
    
    func didTokenExpire() -> Bool
    {
        let currenDate = Date(timeIntervalSinceNow: 0)
        return (currenDate == expirationDate)
    }
    
    func getUser(user: String)
    {
        if (didTokenExpire())
        {
            print("\n\n\nit expiration\n\n\n")
            appLogin()
        }
        let semaphore = DispatchSemaphore(value: 0)
        
        clearUser();
        print("Retrieving User!");
        let link = "https://api.intra.42.fr/v2/users/\(user)"
        let authEndPoint: String = link;
        let url = URL(string: authEndPoint)
        
        var request = URLRequest(url: url!)
        request.setValue("Bearer " + Token , forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        let session = URLSession.shared
        
        let task = session.dataTask(with: request, completionHandler:
        {
            (data, response, error) -> Void in
            
            if (error != nil)
            {
                let alert = UIAlertController(title: "Error!", message: "User not found!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
            
            if data != nil
            {
                do
                {
                    //here Data Response received from a network request
                    let jsonResponse = try JSONSerialization.jsonObject(with:
                        data!, options: [])
                    
                    let json = JSON(jsonResponse);
        
                    id = "\(json["id"])";
                    name = "\(json["displayname"])";
                    email = "\(json["email"])";
                    correction_point = "\(json["correction_point"])";
                    image_url = "\(json["image_url"])";
                    phone = "\(json["phone"])";
                    pool_year = "\(json["pool_year"])";
                    wallet = "\(json["wallet"])";
                    
                    var newImage_url = ""
                    
                    if image_url.lowercased().range(of:"default") != nil
                    {
                       newImage_url =  "https://cdn.intra.42.fr/users/medium_default.png"
                    }
                    else
                    {
                        newImage_url = image_url.components(separatedBy:user)[0]
                        newImage_url.append("medium_")
                        newImage_url.append(user)
                        newImage_url.append(".jpg")
                    }
                    
                    ProfileViewController.realImageUrl = newImage_url
    
                    if let items = json["cursus_users"][0]["skills"].array
                    {
                        for item in items
                        {
                            let newSkill = skill(id: item["id"].intValue, name: item["name"].stringValue, level: item["level"].intValue)
                            skills.append(newSkill);
                        }
                    }
                    
                    
                    if let items = json["projects_users"].array
                    {
                        for item in items
                        {
                            let newProject = project(id: item["id"].intValue, name: item["project"]["name"].stringValue, final_mark: item["final_mark"].intValue)
                            projects.append(newProject);
                        }
                    }
                    
                    login = "\(json["login"])"
                    
                    
                    semaphore.signal()
                }
                catch let parsingError
                {
                    print("Error", parsingError)
                }
            }
            
        })
        task.resume()
        let timeout = DispatchTime.now() + DispatchTimeInterval.seconds(5);
        if semaphore.wait(timeout: timeout) == DispatchTimeoutResult.timedOut
        {
            print("Test timed out");
        }
        else
        {
            self.openTabView();
        }
    }
    
    func clearUser()
    {
        name = "";
        id = "";
        email = "";
        correction_point = "";
        image_url = "";
        phone = "";
        pool_year = "";
        wallet = "";
        skills = [];
        projects = [];
        login = "";
    }
    
    func openTabView()
    {
        if(wallet != "null" && wallet.count >= 0)
        {
            performSegue(withIdentifier: "ProfileSegue", sender: self)
        }
        else
        {
            let alert = UIAlertController(title: "Error!", message: "User not found!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
}
