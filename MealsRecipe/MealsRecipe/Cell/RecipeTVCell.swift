//
//  RecipeTVCell.swift
//  MealsRecipe
//
//  Created by Rodney Pinto on 25/07/24.
//

import UIKit
import Kingfisher

class RecipeTVCell: UITableViewCell {
    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var ingredientsCV: UICollectionView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var viewmoreBTN: UIButton!
    @IBOutlet weak var recipeDesc: UILabel!
    
    //MARK:- Category Detail Declaration
    var recipeDetail : Meal?
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        ingredientsCV.register(UINib(nibName: "IngredientsCVCell", bundle: nil), forCellWithReuseIdentifier: "IngredientsCVCell")
        setupViews()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupViews(){
        imgView.layer.cornerRadius = 10
        baseView.layer.cornerRadius = 10
        baseView.layer.masksToBounds = true
        baseView.layer.shadowColor = UIColor.black.cgColor
        baseView.layer.shadowOpacity = 1
        baseView.layer.shadowOffset = .zero
        baseView.layer.shadowRadius = 10
        registerCollectionView(width: 90, height: 100, cellReuseIdentifier: "IngredientsCVCell")
        ingredientsCV.delegate = self
        ingredientsCV.dataSource = self
    }
    
    func registerCollectionView(width:CGFloat,height:CGFloat,cellReuseIdentifier:String)
    {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 8.0
        flowLayout.minimumInteritemSpacing = 0.0
        flowLayout.itemSize = CGSize(width: width - 20, height: height)
        self.ingredientsCV.collectionViewLayout = flowLayout
        self.ingredientsCV.showsHorizontalScrollIndicator = false
        
        let cellNib = UINib(nibName: cellReuseIdentifier, bundle: nil)
        ingredientsCV.register(cellNib, forCellWithReuseIdentifier: cellReuseIdentifier)
        
        ingredientsCV.reloadData()
    }
    
}

extension RecipeTVCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipeDetail?.ingredients.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IngredientsCVCell", for: indexPath) as! IngredientsCVCell
        cell.ingredientLbl.text = recipeDetail?.ingredients[indexPath.row]
        if let imageUrlString = imageUrl(for: cell.ingredientLbl.text ?? "potatoes") {
            cell.ingredientImg.kf.setImage(with: imageUrlString)
        }
        return cell
    }
    
    // Add spaces at the beginning and the end of the collection view
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 0, bottom: 10, right: 0)
    }
    
    
    func imageUrl(for ingredient: String) -> URL? {
        let baseUrl = "https://www.themealdb.com/images/ingredients/"
        let formattedIngredient = ingredient.lowercased()
        let urlString = "\(baseUrl)\(formattedIngredient).png"
        return URL(string: urlString)
    }
    
}
