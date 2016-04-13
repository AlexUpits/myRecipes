require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup 
    @chef = Chef.create(chefName: "bob", email: "bob2@bob.com")
    @recipe = @chef.recipes.build(name: "bolo simples", summary: "um bolo rapido e delicioso", 
        description: "2 xícaras de açúcar, 3 xícaras de farinha de trigo, 4 colheres de margarina 3 ovos")
  end
  
  test "recipe should be valid" do
    assert @recipe.valid?
  end
  
  test "chef_id should be present" do
    @recipe.chef_id = nil
    assert_not @recipe.valid?
  end
  
  test "name should be present" do
    @recipe.name = " "
    assert_not @recipe.valid?
    # assert @recipe.name.present?
  end
  
  test "name length not to be too long" do
    @recipe.name = "a" * 101
    assert_not @recipe.valid?
  end
  
  test "name length not to be too short" do
    @recipe.name = "a"
    assert_not @recipe.valid?
  end
  
  test "summary should be present" do
    @recipe.summary = " "
    assert_not @recipe.valid?
    # assert @recipe.summary.present?
  end
  
  test "summary length not to be too long" do
    @recipe.summary = "a" * 151 
    assert_not @recipe.valid?
  end
  
  test "summary length not to be to short" do
    @recipe.summary = "aaaaaaa"
    assert_not @recipe.valid?
  end
  
  test "description should be present" do
    @recipe.description = " "
    assert_not @recipe.valid?
  end
  
  test "description length not to be too long" do
    @recipe.description = "a" * 501
    assert_not @recipe.valid?
  end
  
  test "description length not to be too short" do
    @recipe.description = "aaaaaaa"
    assert_not @recipe.valid?
  end
end
