class CreateJoinTableRecipeIngredient < ActiveRecord::Migration
  def change
    create_table :recipe_ingredient do |t|
      t.integer :recipe_id, :ingredient_id
    end
  end
end
