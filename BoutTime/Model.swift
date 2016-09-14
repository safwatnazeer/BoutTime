//
//  Model.swift
//  BoutTime
//
//  Created by Safwat Shenouda on 14/09/16.
//  Copyright © 2016 Safwat Shenouda. All rights reserved.
//

import Foundation
import GameKit


// Struct to hold info about an event
struct HistoryEvent {
    let event : String  //event description
    let year: Int       // event year
    let link: String?   // web link to more info about event

}

// extend struct to allow comparision of events based on description and year
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




// core game model
class BoutTime {
    
    var listOfEvents = [HistoryEvent]()         // lsit of all events
    var currentRoundData =  [HistoryEvent]()    // list of events used for current round
    var orderedRoundData = [HistoryEvent]()     // list of events for current round but with right chronological order
    var gameScore = 0                           // current score for previous rounds
    var numberOfRoundsPlayed = 0                // holds how many rounds played so far
    let maxRoundsPerGame = 6                    // game has 6 rounds
    let maxTimeAllowed = 60                     // round time 60 seconds
    var roundConcluded: Bool = false            // bool to be set at end of round, so score can be caculated one time per round
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
            link: "https://en.wikipedia.org/wiki/United_States_presidential_election,_1960"))
        listOfEvents.append(HistoryEvent(
            event: "Aftermath of the Victory over Japan Day celebrations in New York City.", year: 1945,
            link: "https://en.wikipedia.org/wiki/Victory_over_Japan_Day"))
        listOfEvents.append(HistoryEvent(
            event: "The Hollywood sign was built", year: 1923,
            link: "https://en.wikipedia.org/wiki/Hollywood_Sign"))
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
            link: "https://prezi.com/lwmlexk-kxoi/when-the-first-bananas-came-to-norway-1905/"))
        
        listOfEvents.append(HistoryEvent(
            event: "Young Adolf Hitler celebrating the announcement of World War One", year: 1914,
            link: "http://www.dailymail.co.uk/news/article-2717026/Famous-image-showing-Adolf-Hitler-celebrating-start-First-World-War-FAKE-s-partly-length-moustache.html"))
        listOfEvents.append(HistoryEvent(
            event: "Tearing Down of Berlin Wall", year: 1989,
            link: "https://en.wikipedia.org/wiki/Berlin_Wall"))
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
      
        listOfEvents.append(HistoryEvent(
            event: "Turks defeated outside Vienna", year: 1683,
            link: "https://en.wikipedia.org/wiki/Battle_of_Vienna"))
        listOfEvents.append(HistoryEvent(
            event: "Battle of Waterloo: Napoleon exiled to St Helena", year: 1815,
            link: "https://en.wikipedia.org/wiki/Napoleon"))
        listOfEvents.append(HistoryEvent(
            event: "Unification of Italy", year: 1861,
            link: "https://en.wikipedia.org/wiki/Italian_unification"))
        listOfEvents.append(HistoryEvent(
            event: "Operation Barbarossa: German invasion of Russia", year: 1941,
            link: "https://en.wikipedia.org/wiki/Operation_Barbarossa"))
        listOfEvents.append(HistoryEvent(
            event: "Democracy restored in Spain", year: 1975,
            link: "https://en.wikipedia.org/wiki/History_of_Spain_(1975%E2%80%93present)"))
        
        
    }
    
    // MARK: Methods
    // Function to randomely select events to be used in around
    func createRoundData()
    {
        // increase played round counter
        numberOfRoundsPlayed += 1
        
        // reset roundConcluded 
        roundConcluded = false
        
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
        
        // sort events by year and store ordered array
        orderedRoundData =  currentRoundData.sort {
            $0.year < $1.year
        }
   
    }
    
    
    // Check if events on screen are in correct order
    //
    func isCorrectOrder() -> Bool {
        if
            orderedRoundData[0] == currentRoundData[0] &&
            orderedRoundData[1] == currentRoundData[1] &&
            orderedRoundData[2] == currentRoundData[2] &&
            orderedRoundData[3] == currentRoundData[3]
        {
            if !roundConcluded {
                gameScore += 1
                roundConcluded = true
            }
            return true
        } else {
            return false
        }
        
    }
    
    // Function to swap events in the array
    //
    func swapCurrentRoundData(index1: Int, index2: Int) {
        
        let temp = currentRoundData[index1]
        currentRoundData[index1] = currentRoundData[index2]
        currentRoundData[index2] = temp
    }
    
    //Funciton to check if game over 
    func isGameOver() -> Bool {
        return !(numberOfRoundsPlayed < maxRoundsPerGame)
    }
    
    // Function reset score, rounds for new game
    func prepareNewGame() {
        gameScore = 0
        numberOfRoundsPlayed = 0
    }
    
    // Method to give back final score when game is finished
    func getFinalScore()-> String {
       return "\(gameScore)/\(maxRoundsPerGame)"
    }
    
}



















