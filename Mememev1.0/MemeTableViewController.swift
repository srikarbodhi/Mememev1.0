//
//  MemeTableViewController.swift
//  Mememev1.0
//
//  Created by Srikar Thottempudi on 2/20/19.
//  Copyright © 2019 Srikar Thottempudi. All rights reserved.
//

import UIKit

class MemeTableViewController: UIViewController {
    @IBOutlet weak var memeTableView: UITableView!
    
    var memes: [MememeGenerator]! {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.memes
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        memeTableView.reloadData() // Refreshing memes array for new memes created and making sure all components are rendered on the screen.
        if memes.count == 0 {
            displayAddMeme(memeTableView)
        } else {
            displaySentMeme(memeTableView)
        }
    }

}

extension MemeTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let memeCell = tableView.dequeueReusableCell(withIdentifier: "MemeTableViewCell") as! CustomTableViewCell
        let memeAtPosition = memes[indexPath.row]
        memeCell.customMemeImage.image = memeAtPosition.memeMeImage
        memeCell.customMemeText.text = "\(memeAtPosition.topTextFieldInImage + " " + memeAtPosition.bottomTextFieldInImage)"
        return memeCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("did select row at is called")
        let memeDetailController = storyboard?.instantiateViewController(withIdentifier: "MemeDetailController") as! MemeDetailViewController
        memeDetailController.detailImage = memes[indexPath.row].memeMeImage
        navigationController?.pushViewController(memeDetailController, animated: true)
    }
    
    private func displayAddMeme(_ tableView: UITableView) {
        let addMemeMessageLabel = UILabel()
        addMemeMessageLabel.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 60)
        addMemeMessageLabel.center = self.view.center
        addMemeMessageLabel.textColor = UIColor.brown
        addMemeMessageLabel.textAlignment = .center
        addMemeMessageLabel.text = "There are no sent memes. Click \("'+'") to add memes."
        tableView.backgroundView = addMemeMessageLabel
        tableView.separatorStyle = .none
    }
    
    private func displaySentMeme(_ tableView: UITableView) {
        tableView.backgroundView = nil
        tableView.separatorStyle = .singleLine
    }
    
}
