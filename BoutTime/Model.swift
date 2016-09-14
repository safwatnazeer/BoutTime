//
//  Model.swift
//  BoutTime
//
//  Created by Safwat Shenouda on 14/09/16.
//  Copyright © 2016 Safwat Shenouda. All rights reserved.
//

import Foundation
import GameKit

struct HistoryEvent {
    
    let event : String
    let year: Int
    let link: NSURL?

}

extension HistoryEvent: Equatable {}

func ==(lhs: HistoryEvent, rhs: HistoryEvent) -> Bool
{
    if lhs.event == rhs.event && lhs.year == rhs.year {
    return true
    }
    else {
        return false
    }
}





class BoutTime {
    
    var listOfEvents = [HistoryEvent]()
    var currentRoundData =  [HistoryEvent]()
    var orderedRoundData = [HistoryEvent]()
    
    // Initializer
    init() {
     
        listOfEvents.append(HistoryEvent(event: "event 1980 that is very important ans can span over manylines to test how lines behave", year: 1980, link: nil))
        listOfEvents.append(HistoryEvent(event: "event 1985 that is very important ans can span over manylines to test how lines behave", year: 1985, link: nil))
        listOfEvents.append(HistoryEvent(event: "event  that is very important ans can span over manylines to test how lines behave 1970", year: 1970, link: nil))
        listOfEvents.append(HistoryEvent(event: "event  that is very important ans can span over manylines to test how lines behave 2001", year: 2001, link: nil))
        listOfEvents.append(HistoryEvent(event: "event  that is very important ans can span over manylines to test how lines behave 1919", year: 1919, link: nil))
        listOfEvents.append(HistoryEvent(event: "event  that is very important ans can span over manylines to test how lines behave 1810", year: 1810, link: nil))
        listOfEvents.append(HistoryEvent(event: "event  that is very important ans can span over manylines to test how lines behave 1512", year: 1512, link: nil))
        listOfEvents.append(HistoryEvent(event: "event  that is very important ans can span over manylines to test how lines behave 1700", year: 1700, link: nil))
        listOfEvents.append(HistoryEvent(event: "event  that is very important ans can span over manylines to test how lines behave 1516", year: 1516, link: nil))
        listOfEvents.append(HistoryEvent(event: "event  that is very important ans can span over manylines to test how lines behave 2009", year: 2009, link: nil))

        
    }
    
    // MARK: Methods
    func createRoundData() 
    {
        // clear previous round data
        currentRoundData.removeAll()
        orderedRoundData.removeAll()
        
        // random selection of data
        var listOfInicesUsed = [Int]()
        while currentRoundData.count < 4
        {
            let index = GKRandomSource.sharedRandom().nextIntWithUpperBound(listOfEvents.count)
            if !listOfInicesUsed.contains(index)
            {
                currentRoundData.append(listOfEvents[index])
                listOfInicesUsed.append(index)
            }
        }
        
        // sort events by year and store for future reference
        orderedRoundData =  currentRoundData.sort {
            $0.year < $1.year
        }
   // print("sorted data: \n \(currentRoundData) \n\n\n")
    }
    
    
    // Check correct order
    //
    func isCorrectOrder() -> Bool {
        return(
            orderedRoundData[0] == currentRoundData[0] &&
            orderedRoundData[1] == currentRoundData[1] &&
            orderedRoundData[2] == currentRoundData[2] &&
            orderedRoundData[3] == currentRoundData[3]
        )
        
    }
    
    // swap data
    //
    func swapCurrentRoundData(index1: Int, index2: Int) {
        
        let temp = currentRoundData[index1]
        currentRoundData[index1] = currentRoundData[index2]
        currentRoundData[index2] = temp
    }
    
}



















