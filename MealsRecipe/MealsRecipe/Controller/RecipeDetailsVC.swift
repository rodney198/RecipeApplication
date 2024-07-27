//
//  RecipeDetailsVC.swift
//  MealsRecipe
//
//  Created by Rodney Pinto on 26/07/24.
//

import UIKit
import Kingfisher

class RecipeDetailsVC: UIViewController {
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var ingredientListTV: UITableView!
    @IBOutlet weak var bannerImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var dismissBtn: UIButton!
    @IBOutlet weak var viewYoutubebtn: UIButton!
    
    let ingredientCellReuseIdentifier = "IngredientsTVCell"
    //MARK:- Category Detail Declaration
    var recipeDetail : Meal?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupData()
        setupTableView()
    }
    
    @IBAction func dismissBtnAction(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func viewYouTube() {
        let urlData = recipeDetail?.strYoutube as? String
        guard let linkURL = URL(string: urlData ?? "https://apple.com") else {
            print("Invalid URL")
            return
        }
        
        if UIApplication.shared.canOpenURL(linkURL) {
            UIApplication.shared.open(linkURL, options: [:], completionHandler: nil)
        } else {
            print("Cannot open URL")
        }
    }
    
    func setupTableView() {
        ingredientListTV.dataSource = self
        ingredientListTV.delegate = self
        let cellNib1 = UINib(nibName: ingredientCellReuseIdentifier, bundle: nil)
        self.ingredientListTV.register(cellNib1, forCellReuseIdentifier: "IngredientsTVCell")
    }
    
    func setupData() {
        viewYoutubebtn.layer.cornerRadius = 10
        cardView.roundCorners([.topLeft, .topRight] , radius: 30)
        if let imageUrlString = recipeDetail?.strMealThumb, let imageUrl = URL(string: imageUrlString) {
            self.bannerImg.kf.setImage(with: imageUrl)
        }
        self.titleLbl.text = recipeDetail?.strMeal
        self.descriptionLbl.text = recipeDetail?.strInstructions
    }
    
    func imageUrl(for ingredient: String) -> URL? {
        let baseUrl = "https://www.themealdb.com/images/ingredients/"
        let formattedIngredient = ingredient.lowercased()
        let urlString = "\(baseUrl)\(formattedIngredient).png"
        return URL(string: urlString)
    }

}


extension RecipeDetailsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeDetail?.ingredients.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:IngredientsTVCell = tableView.dequeueReusableCell(withIdentifier: "IngredientsTVCell") as! IngredientsTVCell
        let ingredients = recipeDetail?.ingredients[indexPath.row]
        
        if let imageUrlString = imageUrl(for: ingredients ?? "potatoes") {
            cell.ingredientImg.kf.setImage(with: imageUrlString)
        }
        cell.ingredientLabel.text = recipeDetail?.ingredients[indexPath.row]
        cell.ingredientQty.text = recipeDetail?.measures[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 82
    }
}
