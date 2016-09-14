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
    let link: String?

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
     
        listOfEvents.append(HistoryEvent(
            event: "Martin Luther King Jr.’s 'I have a dream' speech.", year: 1963,
            link: "https://en.wikipedia.org/wiki/I_Have_a_Dream"))
        listOfEvents.append(HistoryEvent(
            event: "The iceberg believed to have sunk the Titanic", year: 1912,
            link: "https://en.wikipedia.org/wiki/Sinking_of_the_RMS_Titanic"))
        listOfEvents.append(HistoryEvent(
            event: "Wilbur Wright flies around the Statue of Liberty.", year: 1909,
            link: "https://en.wikipedia.org/wiki/Wright_Brothers_flights_of_1909"))
        listOfEvents.append(HistoryEvent(
            event: "Jackie Kennedy watching her husband debate Richard Nixon", year: 1960,
            link: "http://www.history.com/topics/us-presidents/kennedy-nixon-debates"))
        listOfEvents.append(HistoryEvent(
            event: "Aftermath of the Victory over Japan Day celebrations in New York City.", year: 1945,
            link: "https://en.wikipedia.org/wiki/Victory_over_Japan_Day"))
        listOfEvents.append(HistoryEvent(
            event: "The Hollywood sign right after it was built", year: 1923,
            link: "http://hollywoodsign.org/1923-a-sign-is-born/"))
        listOfEvents.append(HistoryEvent(
            event: "Neil Armstrong walked on the moon", year: 1969,
            link: "https://www.nasa.gov/mission_pages/apollo/apollo11.html"))
        listOfEvents.append(HistoryEvent(
            event: "JFK giving his famous 'Ich bin ein berliner' speech in Berlin, Germany.", year: 1963,
            link: "https://en.wikipedia.org/wiki/Ich_bin_ein_Berliner"))
        listOfEvents.append(HistoryEvent(
            event: "Signing of the Treaty of Versailles.", year: 1919,
            link: "http://www.eyewitnesstohistory.com/versailles.htm"))
        listOfEvents.append(HistoryEvent(
            event: "Norway's first ever shipment of bananas.", year: 1905,
            link: "http://rarehistoricalphotos.com/bananas-norway-1905/"))
            ////////
        listOfEvents.append(HistoryEvent(
            event: "Young Adolf Hitler celebrating the announcement of World War One", year: 1914,
            link: "http://rarehistoricalphotos.com/young-hitler-cheers-start-world-war-one-august-1914/"))
        listOfEvents.append(HistoryEvent(
            event: "Tearing Down of Berlin Wall", year: 1989,
            link: "http://news.bbc.co.uk/onthisday/hi/witness/november/9/newsid_3241000/3241641.stm"))
        listOfEvents.append(HistoryEvent(
            event: "American Revolution", year: 1765,
            link: "https://en.wikipedia.org/wiki/American_Revolution"))
        listOfEvents.append(HistoryEvent(
            event: "Gutenberg's Printing Press", year: 1440,
            link: "https://en.wikipedia.org/wiki/Printing_press"))
        listOfEvents.append(HistoryEvent(
            event: "French Revolution", year: 1789,
            link: "https://en.wikipedia.org/wiki/French_Revolution"))
        listOfEvents.append(HistoryEvent(
            event: "Edict of Milan: Constantine accepts Christianity", year: 313,
            link: "https://en.wikipedia.org/wiki/Constantine_the_Great_and_Christianity"))
        listOfEvents.append(HistoryEvent(
            event: "Muslim invasion of Spain", year: 711,
            link: "https://en.wikipedia.org/wiki/Umayyad_conquest_of_Hispania"))
        listOfEvents.append(HistoryEvent(
            event: "Jerusalem falls to First Crusade", year: 1099,
            link: "https://en.wikipedia.org/wiki/Siege_of_Jerusalem_(1099)"))
        listOfEvents.append(HistoryEvent(
            event: "Start of the Hundred Year’s War", year: 1337,
            link: "https://en.wikipedia.org/wiki/Hundred_Years%27_War"))
        listOfEvents.append(HistoryEvent(
            event: "Luther’s 95 theses launch the Reformation", year: 1517,
            link: "https://en.wikipedia.org/wiki/Ninety-five_Theses"))
            // ............
        listOfEvents.append(HistoryEvent(
            event: "Turks defeated outside Vienna", year: 1683,
            link: "https://en.wikipedia.org/wiki/Battle_of_Vienna"))
        listOfEvents.append(HistoryEvent(
            event: "Battle of Waterloo: Napoleon exiled to St Helena", year: 1815,
            link: "http://www.eyewitnesstohistory.com/napoleon.htm"))
        listOfEvents.append(HistoryEvent(
            event: "Wilbur Wright flies around the Statue of Liberty.", year: 1909,
            link: "https://en.wikipedia.org/wiki/Wright_Brothers_flights_of_1909"))
        listOfEvents.append(HistoryEvent(
            event: "Jackie Kennedy watching her husband debate Richard Nixon", year: 1960,
            link: "http://www.history.com/topics/us-presidents/kennedy-nixon-debates"))
        listOfEvents.append(HistoryEvent(
            event: "Aftermath of the Victory over Japan Day celebrations in New York City.", year: 1945,
            link: "https://en.wikipedia.org/wiki/Victory_over_Japan_Day"))
        
        
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



















