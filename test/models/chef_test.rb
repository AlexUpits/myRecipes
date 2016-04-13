require 'test_helper'

class ChefTest < ActiveSupport::TestCase
  
  def setup 
    @chef = Chef.new(chefName: "Alex", email: "alex@gmail.com")
  end

  test "chef should be valid" do
    assert @chef.valid?
  end
 
  test "chefName should be present" do
    @chef.chefName = " "
    assert_not @chef.valid?
  end
  
  test "chefName length not to be too long" do
    @chef.chefName = "a" * 41
    assert_not @chef.valid?
  end
  
  test "chefName length not to be too short" do
    @chef.chefName = "a"
    assert_not @chef.valid?
  end

  test "email should be present" do
    @chef.email = " "
    assert_not @chef.valid?
  end
  
  test "email length should be within bounds" do
    @chef.email = "a" * 101 + "@example.com"
    assert_not @chef.valid?
  end
  
  test "email should be unic" do
    dup_chef = @chef.dup
    dup_chef.email = @chef.email.upcase
    @chef.save
    assert_not dup_chef.valid? 
  end
  
  test "email validation should accept valid address" do
    valid_addresses = %W[user@user.com A-L-E@tex.org.br valid.email@email.com joane+jonh@email.com]
    valid_addresses.each do |va|
      @chef.email = va
      assert @chef.valid?, '#{va.inspect} should be valid'
    end
     
  end
  
  test "email validation should reject invalid address" do
    invalid_addresses = %W[user@user,com user_at_ee.org  A-L-E@tex+org.br valid.email@email. joane+jonh@email_com]
    invalid_addresses.each do |ia|
      @chef.email = ia
      assert_not @chef.valid?, '#{ia.inspect} should be valid'
    end
  end
  
end
