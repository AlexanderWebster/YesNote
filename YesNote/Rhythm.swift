//
//  Rhythm.swift
//  YesNote
//
//  Created by Alexander Webster on 10/25/17.
//  Copyright © 2017 Elad. All rights reserved.
//

import Foundation

class Rhythm {
    
    var currentRhythm: rhythmObj?
    
    // Rhythm data type
    struct rhythmObj {
        var name: String?
        var font: String?
        var midiFile: String?
    }
    
    // Storage for all rhythms
    var rhythmBank = [rhythmObj?]()
    
    init () {
        
        // Add rhythms to storage
        rhythmBank.append(rhythmObj(name: "Metronome", font: "$4 q q q q \\ q q q q \\",midiFile: "Metronome"))
        
        rhythmBank.append(rhythmObj(name: "Charleston", font: "$4 q. e H \\ q. e H \\",midiFile: "Charleston"))
        
        rhythmBank.append(rhythmObj(name: "Dotted Quarter Notes", font: "$4 q. e-q q_ \\ e q. q. e_ \\",midiFile: "DottedQuarterNotes"))
        
        rhythmBank.append(rhythmObj(name: "Upbeats on 1 & 3", font: "$4 E e Q E e Q \\ E e Q E e Q \\",midiFile: "UpbeatsOn1and3"))
        
        rhythmBank.append(rhythmObj(name: "Upbeats on 2 & 4", font: "$4 Q . e Q . e \\ Q . e Q . e \\",midiFile: "UpbeatsOn2and4"))
        
        // Set default rhythm - no crashes!
        currentRhythm = rhythmBank[0]
    }
    
    // Behaviour
    
    func getRhythm() -> (name: String, font: String) {
        return (currentRhythm!.name!, currentRhythm!.font!)
    }
    
    func setRhythm (rhythmChoice: Int) {
        if (rhythmChoice < rhythmBank.count && rhythmBank[rhythmChoice] != nil) {
            currentRhythm = rhythmBank[rhythmChoice]
        }
        else{
            currentRhythm = rhythmBank[0]
        }
    }
    func getMIDIName() -> String {
        return currentRhythm!.midiFile!
    }
    
}


