//
//  SkillsViewController.swift
//  Swifty-Companion
//
//  Created by Goodwill TSHEKELA on 2018/10/23.
//  Copyright © 2018 Kuzivakwashe MUVEZWA. All rights reserved.
//

import UIKit

class SkillsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet weak var skillsTable: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return (skills.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SkillCell", for: indexPath ) as! CustomTableViewCell
        
        cell.name.text = skills[indexPath.row].name
        cell.value.text = String(skills[indexPath.row].level)
        if (indexPath.row % 2 == 0)
        {
            cell.layer.backgroundColor = UIColor(red: 177.0/255.0, green:
                156.0/255.0, blue: 217.0/255.0, alpha: 1.0).cgColor
        }
        else
        {
            cell.layer.backgroundColor = UIColor(red: 150.0/255.0, green:
                111.0/255.0, blue: 214.0/255.0, alpha: 1.0).cgColor
        }
        
        return (cell)
    }
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        skillsTable.delegate = self
        skillsTable.reloadData()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
