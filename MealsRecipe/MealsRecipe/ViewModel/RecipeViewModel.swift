//
//  RecipeViewModel.swift
//  MealsRecipe
//
//  Created by Rodney Pinto on 26/07/24.
//

import Foundation
import Alamofire

class RecipeViewModel {
    static var session: Session = .default
    
    //MARK: - Fetches meal data from the API
    class func fetchMealData(completion: @escaping (Result<[Meal], Error>) -> Void) {
        let url = "https://www.themealdb.com/api/json/v2/1/randomselection.php"

        // Making a request to the API
        session.request(url).responseDecodable(of: MealResponse.self) { response in
            switch response.result {
            case .success(let mealResponse):
                // If meals are found, pass them to the completion handler
                if !mealResponse.meals.isEmpty {
                    completion(.success(mealResponse.meals))
                } else {
                    // Handle the case where no meals are found
                    completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No meals found in response"])))
                }
            case .failure(let error):
                // Pass the error to the completion handler
                completion(.failure(error))
            }
        }
    }
}
