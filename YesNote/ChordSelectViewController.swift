//
//  ChordSelectViewController.swift
//  PickerExample
//
//  Created by Dale Haverstock on 12/1/16.
//  Copyright © 2016 Elad. All rights reserved.
//

import UIKit

class ChordSelectViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let scales = ["Ionian","Dorian","Phrygian","Lydian","Mixolydian","Aeolian","Locrian"]
    let roots = ["C","C#","D","D#","E","F","F#","G","G#","A","A#","B"]
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var selectionLabel: UILabel!
    let mainVC = UIApplication.shared.keyWindow?.rootViewController as! MainViewController?
    
    
    //determine number of colomn------------------------------------------
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 4
    }
    
    
    //determine number of rows in colomns---------------------------------
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if component == 0 {
            //number of rows in colomn 1,3
            return roots.count
        } else if component == 1 {
            //number of rows in colomn 2
            return scales.count
        } else if component == 2 {
            //number of rows in colomn 3
            return 7
        } else if component == 3 {
            //number of rows in colomn 4
            let r2 = scales[picker.selectedRow(inComponent: 1)]
            let r3 = picker.selectedRow(inComponent: 2)
            let chordstext = mainVC?.scaleChordLogic.getChordList(mname: r2, croot: r3)
            return chordstext!.count
        } else{
            //default case
            return 0
        }
    }
    
    
    //add row data and styling to chord picker----------------------------
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        //format row text in picker
        var pickerLabel = view as? UILabel;
        if (pickerLabel == nil)
        {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont(name: "Helvetica Neue", size: 15)
            pickerLabel?.textAlignment = NSTextAlignment.center
        }
        
        if component == 0 {
            //data for colomn 1,3
            pickerLabel?.text = roots[row]
        } else if component == 1 {
            //data for colomn 2
            pickerLabel?.text = scales[row]
        } else if component == 2 {
            //dynamic data for colomn 3
            let r1 = roots [picker.selectedRow(inComponent: 0)]
            let r2 = scales[picker.selectedRow(inComponent: 1)]
            let noteNum = mainVC?.scaleChordLogic.getMode(rt: r1, md: r2)[row]
            pickerLabel?.text = roots[noteNum!]
        } else if component == 3 {
            //dynamic data colomn 4
            let r2 = scales[picker.selectedRow(inComponent: 1)]
            let r3 = picker.selectedRow(inComponent: 2)
            let chordstext = mainVC?.scaleChordLogic.getChordList(mname: r2, croot: r3)
            if (chordstext?.indices.contains(row))! {
                pickerLabel?.text = chordstext?[row]
            }
        } else{
            //default case
            pickerLabel?.text = ""
        }
        
        return pickerLabel!;
    }
    
    
    //display current picker value-------------------------------------------
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerView.reloadAllComponents()
        
        //retrieve  row position values
        let r1 = picker.selectedRow(inComponent: 0)
        let r2 = picker.selectedRow(inComponent: 1)
        let r3 = picker.selectedRow(inComponent: 2)
        let r4 = picker.selectedRow(inComponent: 3)
        
        //assign position values to strings
        let p1 = roots [r1]
        let p2 = scales[r2]
        
        let noteNum = mainVC?.scaleChordLogic.getMode(rt: p1, md: p2)[r3]
        let p3 = roots[noteNum!]
        
        let chordstext = mainVC?.scaleChordLogic.getChordList(mname: p2, croot: r3)
        let p4 = chordstext![r4]

        //format and set string
        let numberString = "\(p1) \(p2) / \(p3) \(p4)"
        let textAttributes = [NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue]
        let attributedString = NSAttributedString(string: numberString, attributes: textAttributes)
        selectionLabel.attributedText = attributedString
        
    }
    
    //handle done button press-----------------------------------------------
    @IBAction func doneButton(_ sender: UIButton) {
        
        //retrieve row position values
        let r1 = picker.selectedRow(inComponent: 0)
        let r2 = picker.selectedRow(inComponent: 1)
        let r3 = picker.selectedRow(inComponent: 2)
        let r4 = picker.selectedRow(inComponent: 3)
        
        //assign position values to strings
        let p1 = roots [r1]
        let p2 = scales[r2]
        
        let modeNotes = mainVC?.scaleChordLogic.getMode(rt: p1, md: p2)
        let p3 = roots[modeNotes![r3]]
        
        let chordstext = mainVC?.scaleChordLogic.getChordList(mname: p2, croot: r3)
        let p4 = chordstext![r4]
        
        //store row data for defaults values next load
        mainVC?.row1 = r1
        mainVC?.row2 = r2
        mainVC?.row3 = r3
        mainVC?.row4 = r4
        mainVC?.row3String = p3
        mainVC?.row4String = p4
        
        //assign row content to UI text
        let chordText = p3 + " " + p4 + " ▾"
        let scaleText = p1 + " " + p2
        mainVC?.chordButton.setTitle(chordText as String, for: .normal)
        mainVC?.scaleLabel.text = scaleText as String
        
        //assign modeNoteLabel
        var modeNotesString = "       "
        for note in modeNotes! {
            let noteString = roots[note]
            modeNotesString.append(noteString)
            if noteString.count == 2 {
                modeNotesString.append("     ")
            }
            else {
                modeNotesString.append("       ")
            }
        }
        let lastNote = roots[modeNotes![0]]
        modeNotesString.append(lastNote)
        mainVC?.modeNoteLabel.text = modeNotesString
        
        //assign scaleNotationLabel and scale notation highlighting
        let scaleString = (mainVC?.scaleChordLogic.getStaff(r: p1, m: p2))!
        let scaleAttributedString = NSMutableAttributedString(string: scaleString)
        let backgrooundColor = UIColor(red:0.00, green:0.59, blue:1.00, alpha:0.3)
        for (index, letter) in scaleString.enumerated() {
            if (mainVC?.scaleChordLogic.getChordInStaff(r: p3, c: p4).contains(letter))! {
                scaleAttributedString.addAttribute(NSBackgroundColorAttributeName, value: backgrooundColor, range: NSRange(location: index, length: 1))
            }
        }
        mainVC?.scaleNotationLabel.attributedText = scaleAttributedString
        
        //updated info for main view to re-initialize
        mainVC?.numNotesInChord = (mainVC?.scaleChordLogic.getChord(pre: p3, suf: p4).count)!
        mainVC?.DroneTableView.reloadData()
        mainVC?.audioPlayer.togglePlay(tempo: 0.0, chord: [])
        mainVC?.resetVariables()
        mainVC?.viewWillLayoutSubviews()
        
        //dismiss popover
        self.dismiss(animated: true, completion: nil)
    }

    
    //initialize view and load default picker values------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
        picker.dataSource = self
        
        //retrieve last known row position values
        let r1 = (mainVC?.row1)!
        let r2 = (mainVC?.row2)!
        let r3 = (mainVC?.row3)!
        let r4 = (mainVC?.row4)!
        
        //assign position values to strings
        let p1 = roots [r1]
        let p2 = scales[r2]
        
        let noteNum = mainVC?.scaleChordLogic.getMode(rt: p1, md: p2)[r3]
        let p3 = roots[noteNum!]

        let chordstext = mainVC?.scaleChordLogic.getChordList(mname: p2, croot: r3)
        let p4 = chordstext![r4]
        
        //restore values to picker
        picker.selectRow(r1, inComponent:0, animated:true)
        picker.selectRow(r2, inComponent:1, animated:true)
        picker.selectRow(r3, inComponent:2, animated:true)
        picker.selectRow(r4, inComponent:3, animated:true)
        
        let numberString = "\(p1) \(p2) / \(p3) \(p4)"
        let textAttributes = [NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue]
        let attributedString = NSAttributedString(string: numberString, attributes: textAttributes)
        selectionLabel.attributedText = attributedString
    }
}


