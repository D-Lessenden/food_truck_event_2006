require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/item'
require './lib/food_truck'

class FoodTruckTest < Minitest::Test

  	def setup
      @food_truck = FoodTruck.new("Rocky Mountain Pies")
  	end

    def test_it_exists
      assert_instance_of FoodTruck, @food_truck
    end

    def test_it_has_name
      assert_equal "Rocky Mountain Pies", @food_truck.name
    end

    def test_it_has_inventory
      result = {}
      assert_equal result, @food_truck.inventory
    end

    def test_check_stock
      item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
      assert_equal 0, @food_truck.check_stock(item1)
    end

    def test_it_can_have_items_stocked
      item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
      item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
      @food_truck.stock(item1, 30)
      result = {item1 => 30}
      assert_equal result, @food_truck.inventory

      assert_equal 30, @food_truck.check_stock(item1)

      @food_truck.stock(item1, 25)
      assert_equal 55, @food_truck.check_stock(item1)

      @food_truck.stock(item2, 12)
      result = {item1 => 55, item2 => 12}
      assert_equal result, @food_truck.inventory
    end



end

# @food_truck.stock(item2, 12)
#
# @food_truck.inventory
#=> {#<Item:0x007f9c56740d48...> => 55, #<Item:0x007f9c565c0ce8...> => 12}
