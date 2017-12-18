//
//  ScaleChordLogic.swift
//  YesNote
//
// Scale and Chord Logic
// Blair McClain
// 10/26/2017
//

import Foundation

class ScaleChordLogic {
    
    let notes = [ "C": 0,
                  "C#": 1,
                  "D": 2,
                  "D#": 3,
                  "E": 4,
                  "F": 5,
                  "F#": 6,
                  "G": 7,
                  "G#": 8,
                  "A": 9,
                  "A#": 10,
                  "B": 11]
    
    let flats = [ "C#": "Db",
                  "D#": "Eb",
                  "F#": "Gb",
                  "G#": "Ab",
                  "A#": "Bb"]
    
    let note_names = [ "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"]
    
    let scale = [ 0, 2, 4,  5,  7,  9, 11]
    
    let modes = [ "Ionian": 0,
                  "Dorian": 1,
                  "Phrygian": 2,
                  "Lydian": 3,
                  "Mixolydian": 4,
                  "Aeolian": 5,
                  "Locrian": 6]
    
    let c_chords = ["major": [0, 4, 7],
                    "maj7": [0, 4, 7, 11],
                    "maj9": [0, 4, 7, 11, 2],
                    "maj13": [0, 4, 7, 11, 2, 9],
                    "add6": [0, 4, 7, 9],
                    "6/9": [0, 4, 9, 2],
                    "sus2": [0, 2, 7],
                    "sus4": [0, 5, 7],
                    "7": [0, 4, 7, 10],
                    "9": [0, 4, 7, 10, 2],
                    "13": [0, 4, 7, 10, 2, 9],
                    "7sus4": [0, 5, 7, 10],
                    "11": [0, 4, 7, 10, 2, 5],
                    "minor": [0, 3, 7],
                    "m7": [0, 3, 7, 10],
                    "m9": [0, 3, 7, 10, 2],
                    "m11": [0, 3, 5, 7, 10],
                    "m13": [0, 3, 7, 10, 2, 9],
                    "dim": [0, 3, 6]]
    
    let mi_chords = [["major", "maj7", "maj9", "maj13", "add6", "6/9", "sus2", "sus4"],
                     ["minor", "m7", "m9", "m13", "sus2", "sus4", "7sus4"],
                     ["minor", "m7", "sus2", "sus4"],
                     ["major", "maj7", "maj9", "add6", "6/9", "sus2"],
                     ["major", "7", "9", "11", "13", "6/9", "sus2", "sus4", "7sus4"],
                     ["minor", "m7", "m9", "m11", "m13", "sus2", "sus4", "7sus4"],
                     ["dim"]]
    
    let note_staff_names = [ "a", "A", "s", "S", "d", "f", "F", "g", "G", "h", "H", "j", "q", "Q", "w", "W", "e", "r", "R", "t", "T", "y", "Y", "u"]
    
    // shifts a integer representing a note by a given shift amount
    func shift(root: Int, sham: Int) -> Int {
        return (root + sham) % 12
    }
    
    // shifts an array of integers by a given shift ammount
    func shiftArr(input: Array<Int>, amt: Int) -> Array<Int> {
        var tmp = Array<Int>()
        for n in input{
            tmp.append(shift(root: n, sham: amt))
        }
        return tmp
    }
    
    // creats shifted array of chords for a given mode
    func shiftChords(mod: Int) -> Array<Array<String>> {
        var tmp = Array<Array<String>>()
        for i in 0...6{
            tmp.append(mi_chords[(mod+i)%7])
        }
        return tmp
    }
    
    //shifts an ionian array to given mode
    func modeShift(src base: Array<Int>, mode sham: Int) -> Array<Int> {
        var tmp = Array<Int>()
        for dex in 0...6{
            tmp.append(base[(sham+dex)%7])
        }
        return tmp
    }
    
    //returns the offset for the shift amount
    func shoff(src: Int) -> Int{
        return (12-scale[src])%12 //offset is the amount the ionian root needs to be shifted
    }
    
    // returns an array of a given mode
    func getMode(rt: String, md: String) -> Array<Int>{
        let tmp = shiftArr(input: scale, amt: notes[rt]!+shoff(src: modes[md]!)) //create temporary ionian array
        return modeShift(src: tmp, mode: modes[md]!) //shift array to proper mode
    }
    
    func getChord(pre: String, suf: String) -> Array<Int>{
        return shiftArr(input: c_chords[suf]!, amt: notes[pre]!)
    }
    
    func getChordList(mname: String, croot: Int) -> Array<String>{
        let tmp = shiftChords(mod: modes[mname]!)
        return tmp[croot]
    }
    
    func getStaff(r: String, m: String) -> String{
        let tmp = getMode(rt: r, md: m)
        var staff = "&"
        for n in tmp{
            if (n < tmp[0]){
                staff.append(note_staff_names[n+12])
            }
            else{
                staff.append(note_staff_names[n])
            }
            let test = staff.lowercased()
            if (test.last == staff.last){
                staff.append("=")
            }
        }
        staff.append(note_staff_names[tmp[0]+12])
        staff.append("||")
        return staff
    }
    
    func getChordInStaff(r: String, c: String) -> String{
        let tmp = getChord(pre: r, suf: c)
        var staff = ""
        for n in tmp{
                staff.append(note_staff_names[n+12])
                staff.append(note_staff_names[n])
        }
        return staff
    }
}
