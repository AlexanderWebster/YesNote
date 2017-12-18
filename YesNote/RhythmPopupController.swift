//
//  RhythmPopupController.swift
//  YesNote
//
//  Created by Jeff Tobin on 10/25/17.
//  Copyright © 2017 Elad. All rights reserved.
//

import UIKit

class RhythmPopupController: UITableViewController {
    
    let mainVC = UIApplication.shared.keyWindow?.rootViewController as! MainViewController?
    
    //set initial row selection
    override func viewDidAppear(_ animated: Bool) {
        tableView.selectRow (at: (mainVC?.selectedRow)!, animated: false, scrollPosition: UITableViewScrollPosition.middle)
        tableView.cellForRow(at: (mainVC?.selectedRow)!)?.accessoryType = .checkmark
    }
    
    //disable row highlighting
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.selectionStyle = .none
    }

    //add checkmark and log row
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
        //store result
        mainVC?.selectedRow = indexPath
        
        mainVC?.rhythmObj.setRhythm(rhythmChoice: indexPath.row)
        mainVC?.rhythmNotationLabel.text = mainVC?.rhythmObj.getRhythm().font
        
        //pause drones
        mainVC?.audioPlayer.togglePlay(tempo: 0.0, chord: [])
        
        //dismiss popover on main thread
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    //remove checkmark
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }

}
