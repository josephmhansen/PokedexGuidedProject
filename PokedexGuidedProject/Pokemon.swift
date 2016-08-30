//
//  Pokemon.swift
//  PokedexGuidedProject
//
//  Created by Joseph Hansen on 8/30/16.
//  Copyright © 2016 Joseph Hansen. All rights reserved.
//

import Foundation

struct Pokemon {
    
    private let kName = "name"
    private let kID = "id"
    private let kAbilities = "abilities"
    private let kAbility = "ability"
    
    
    let name: String
    let id: Int
    let abilities: [String] = []
}

extension Pokemon {
    init?(dictionary: [String: AnyObject]) {
        guard let name = dictionary[kName] as? String,
        id = dictionary[kID] as? Int,
            abilitiesArray = dictionary[kAbilities] as? [[String: AnyObject]] else  { return nil }
        
        let abilityDictionary = abilitiesArray.flatMap({$0[kAbility]} as? [String: AnyObject])
        let abilities = abilityDictionaries.flatMap{$0[kName]} as? String
        
        self.init(name: name, id: id, abilities: abilities)
        
        

    }
}
