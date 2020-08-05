require 'date'
class Event
attr_reader :name, :food_trucks

  def initialize(name)
    @name = name
    @food_trucks = []
  end

  def add_food_truck(truck)
    @food_trucks << truck
  end

  def food_truck_names
    names = []
    @food_trucks.each do |truck|
      names << truck.name
    end
    names
  end

  def food_trucks_that_sell(item)
    trucks_that_sell = []
    @food_trucks.each do |truck|
      trucks_that_sell << truck if truck.inventory.include?(item)
    end
    trucks_that_sell
  end

  def total_inventory
    event_inventory = Hash.new do |event_inventory, item|
      event_inventory[item] = {quantity: 0, food_trucks: []}
    end
    @food_trucks.each do |truck|
      truck.inventory.each do |truck_item, quantity|
        event_inventory[truck_item][:quantity] += quantity
        event_inventory[truck_item][:food_trucks] << truck
      end
    end
    event_inventory
  end

  def overstocked_items
    overstocked = []
    total_inventory.each do |item, truck|
      if truck[:food_trucks].count > 1 && truck[:quantity] > 50
        overstocked << item
      end
    end
    overstocked
  end

  def sorted_item_list
    total_inventory.map do |item, truck|
      item.name
    end.sort
  end

  # def date
  #    @date.strftime("%e %m %y")
  # end

  def sell(item, quantity)
    if total_inventory[item].nil? || total_inventory[item][:quantity] < quantity
      return false
    else
      @food_trucks.each do |truck|
        if truck.check_stock(item) > quantity
          new_stock = truck.check_stock(item) - quantity
        else truck.check_stock(item) < quantity
          quantity = quantity - truck.check_stock(item)
          new_stock = truck.check_stock(item) - truck.check_stock(item)
          binding.pry
        end
      end
    end
  end


end
