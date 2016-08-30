//
//  PokemonController.swift
//  PokedexGuidedProject
//
//  Created by Joseph Hansen on 8/30/16.
//  Copyright © 2016 Joseph Hansen. All rights reserved.
//

import Foundation

class PokemonController {
    
    static let baseURL = "http://pokeapi.co/api/v2/pokemon/"
    
    static func fetchPokemon(searchTerm: String, completion: (pokemon: Pokemon?) -> Void) {
        
        let searchURL = baseURL + searchTerm.lowercaseString
        let url = NSURL(string: searchURL)
        guard let unwrappedURL = url else {
            print("No URL Found")
            completion(pokemon: nil)
            return
        }
        
        NetworkController.performRequestForURL(unwrappedURL, httpMethod: .Get) { (data, error) in
            guard let data = data,
                responseDataString = NSString(data: data, encoding: NSUTF8StringEncoding) else {
                    print("Error: No Data Found /n\(error?.localizedDescription)")
                    completion(pokemon: nil)
                    return
            }
            guard let jsonAnyObject = (try? NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)) as? [String: AnyObject] else {
                print("Error Unable to serialize JSON: \(responseDataString)")
                completion(pokemon: nil)
                return
            }
            guard let pokemon = Pokemon(dictionary: jsonAnyObject) else {
            print("No Pokemon Found")
            completion(pokemon: nil)
                return
            }
               dispatch_async(dispatch_get_main_queue(), { () -> Void in
                completion(pokemon: pokemon)
                print("Success: \(pokemon.name)")
                })
                
        }
    }
}
