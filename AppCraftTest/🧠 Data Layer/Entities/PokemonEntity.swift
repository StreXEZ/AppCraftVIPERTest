//
//  PokemonEntity+CoreDataClass.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 26.02.2021.
//
//

import GKCoreData
import CoreData

@objc(PokemonEntity)
public class PokemonEntity: NSManagedObject {
    @NSManaged public var id: NSNumber
    @NSManaged public var height: NSNumber
    @NSManaged public var weight: NSNumber
    @NSManaged public var name: String
    @NSManaged public var is_default: Bool
    @NSManaged public var base_experience: NSNumber
}

extension PokemonEntity: LocalMappable {
    public func mapEntityFromDomain(data: AnyObject) {
        guard let pokemon = data as? PokemonDetailModel else { return }
        self.id = NSNumber(value: pokemon.id)
        self.height = NSNumber(value: pokemon.height)
        self.name = pokemon.name
        self.weight = NSNumber(value:pokemon.weight)
        self.base_experience = NSNumber(value: pokemon.base_experience)
        self.is_default = pokemon.is_default
    }
    
    public func mapEntityToDomain() -> AnyObject {
        let pokemon = PokemonDetailModel()
        pokemon.id = self.id.intValue
        pokemon.height = self.height.intValue
        pokemon.weight = self.weight.intValue
        pokemon.base_experience = self.base_experience.intValue
        pokemon.name = self.name
        pokemon.is_default = self.is_default
        return pokemon
    }
}
