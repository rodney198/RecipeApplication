//
//  Model.swift
//  MealsRecipe
//
//  Created by Rodney Pinto on 26/07/24.
//

import Foundation

struct MealResponse: Codable {
    let meals: [Meal]
}

struct Meal: Codable {
    let strMeal: String
    let strInstructions: String
    let strMealThumb: String
    let strYoutube: String?
    
    let ingredients: [String?]
    let measures: [String?]

    private enum CodingKeys: String, CodingKey {
        case strMeal
        case strInstructions
        case strMealThumb
        case strYoutube
        
        case strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5, strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10, strIngredient11, strIngredient12, strIngredient13, strIngredient14, strIngredient15, strIngredient16, strIngredient17, strIngredient18, strIngredient19, strIngredient20
        case strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5, strMeasure6, strMeasure7, strMeasure8, strMeasure9, strMeasure10, strMeasure11, strMeasure12, strMeasure13, strMeasure14, strMeasure15, strMeasure16, strMeasure17, strMeasure18, strMeasure19, strMeasure20
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        strMeal = try container.decode(String.self, forKey: .strMeal)
        strInstructions = try container.decode(String.self, forKey: .strInstructions)
        strMealThumb = try container.decode(String.self, forKey: .strMealThumb)
        strYoutube = try? container.decode(String.self, forKey: .strYoutube)
        
        var ingredients: [String?] = []
        var measures: [String?] = []
        
        for i in 1...20 {
            let ingredientKey = CodingKeys(rawValue: "strIngredient\(i)")!
            let measureKey = CodingKeys(rawValue: "strMeasure\(i)")!
            
            if let ingredient = try? container.decode(String.self, forKey: ingredientKey) {
                ingredients.append(ingredient)
            } else {
                ingredients.append(nil)
            }
            
            if let measure = try? container.decode(String.self, forKey: measureKey) {
                measures.append(measure)
            } else {
                measures.append(nil)
            }
        }
        
        self.ingredients = ingredients
        self.measures = measures
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(strMeal, forKey: .strMeal)
        try container.encode(strInstructions, forKey: .strInstructions)
        try container.encode(strMealThumb, forKey: .strMealThumb)
        try? container.encode(strYoutube, forKey: .strYoutube)
        
        for (index, ingredient) in ingredients.enumerated() {
            if let ingredient = ingredient, !ingredient.isEmpty {
                let key = CodingKeys(rawValue: "strIngredient\(index + 1)")!
                try container.encode(ingredient, forKey: key)
            }
        }
        
        for (index, measure) in measures.enumerated() {
            if let measure = measure, !measure.isEmpty {
                let key = CodingKeys(rawValue: "strMeasure\(index + 1)")!
                try container.encode(measure, forKey: key)
            }
        }
    }
}

