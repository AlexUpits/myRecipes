class RenameTableNameToNewName < ActiveRecord::Migration
  def change
    rename_table :recipe_ingredient, :recipe_ingredients
    rename_table :recipe_style, :recipe_styles
  end
end
