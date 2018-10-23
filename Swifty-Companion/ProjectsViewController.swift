//
//  ProjectsViewController.swift
//  Swifty-Companion
//
//  Created by Goodwill TSHEKELA on 2018/10/23.
//  Copyright © 2018 Kuzivakwashe MUVEZWA. All rights reserved.
//

import UIKit

class ProjectsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet weak var projectTable: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return (projects.count)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectCell", for: indexPath ) as! CustomTableViewCell
        
        cell.name.text = projects[indexPath.row].name
        cell.value.text = String(projects[indexPath.row].final_mark) + "%"
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
        projectTable.delegate = self
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
       
    }

}
