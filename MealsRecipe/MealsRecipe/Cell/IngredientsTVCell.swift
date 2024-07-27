//
//  IngredientsTVCell.swift
//  MealsRecipe
//
//  Created by Rodney Pinto on 26/07/24.
//

import UIKit

class IngredientsTVCell: UITableViewCell {
    
    @IBOutlet weak var ingredientImg: UIImageView!
    @IBOutlet weak var ingredientLabel: UILabel!
    @IBOutlet weak var ingredientQty: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
