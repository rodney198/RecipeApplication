//
//  ViewController.swift
//  MealsRecipe
//
//  Created by Rodney Pinto on 25/07/24.
//

import UIKit
import Alamofire
import Kingfisher

class ViewController: UIViewController {
    
    @IBOutlet weak var recipeTV: UITableView!
    let recipeCellReuseIdentifier = "RecipeTVCell"
    
    //MARK:- Category Detail Declaration
    var recipeDetail : [Meal]?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTableView()
        fetchDatafromAPI()
    }
    
    func setupTableView() {
        recipeTV.dataSource = self
        recipeTV.delegate = self
        let cellNib1 = UINib(nibName: recipeCellReuseIdentifier, bundle: nil)
        self.recipeTV.register(cellNib1, forCellReuseIdentifier: "RecipeTVCell")
    }
    
    func fetchDatafromAPI() {
        // Fetch meal data
        RecipeViewModel.fetchMealData { result in
            switch result {
            case .success(let fetchedMeals):
                self.recipeDetail = fetchedMeals
                debugPrint(self.recipeDetail as Any)
                DispatchQueue.main.async {
                    // Update UI, reload table view, etc.
                    self.recipeTV.reloadData()
                }
            case .failure(let error):
                print("Error fetching meal data: \(error.localizedDescription)")
                // Handle the error appropriately (e.g., show an alert)
            }
        }
    }
    
    @objc  func passDatatoNextVC(_ sender: UIButton){
        let recipeDetail = recipeDetail?[sender.tag]
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "RecipeDetailsVC") as! RecipeDetailsVC
        nextViewController.recipeDetail = recipeDetail
        nextViewController.modalPresentationStyle = .fullScreen
        self.present(nextViewController, animated: true, completion: nil)
       }
}


//MARK: - Table View Delegate and Datasource Methods
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.recipeDetail?.count ?? 0 > 0{
            return self.recipeDetail?.count ?? 1
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:RecipeTVCell = tableView.dequeueReusableCell(withIdentifier: "RecipeTVCell") as! RecipeTVCell
        cell.setupViews()
        cell.recipeDetail = recipeDetail?[indexPath.row]
        let recipeDetail = recipeDetail?[indexPath.row]
        
        //Add Tag to the Button
        cell.viewmoreBTN.tag = indexPath.row
        cell.viewmoreBTN.addTarget(self, action: #selector(passDatatoNextVC), for: .touchUpInside)
        cell.viewmoreBTN.titleLabel?.font = UIFont(name: "Avenir Next", size: 14)
        
        cell.title.text = recipeDetail?.strMeal
        if let fullString = recipeDetail?.strInstructions {
            // Slice the string to get the first 15 characters and convert to String
            let truncatedString = String(fullString.prefix(72))
            // Set the truncated string to the label
            cell.recipeDesc.text = truncatedString
        } else {
            // Handle the case where `fullString` is nil, if needed
            cell.recipeDesc.text = "No description available"
        }
        
        if let imageUrlString = recipeDetail?.strMealThumb, let imageUrl = URL(string: imageUrlString) {
            cell.imgView.kf.setImage(with: imageUrl)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 450
    }
}
