module Enumerable
  def sort_by_frequency
    histogram = inject(Hash.new(0)) { |hash, x| hash[x] += 1; hash}
    sort_by { |x| [histogram[x], x] }
  end
end
class HarryPotter
  attr_reader :book_cost, :book_list
  def initialize
    @book_cost = 8.00
    @book_list = [:first, :second, :third, :fourth, :fifth]
  end

  def sell(basket)
    grouped_basket = group_basket(basket)
    total_cost = 0
    grouped_basket.values.each do |group|
      total_cost += discount(group)
    end
    p "#{basket.size} ==> #{grouped_basket} => £#{total_cost}"
    total_cost
  end

  def group_basket(basket)
    numbers_of_each = Hash.new(0)
    basket.each do |basket_item|
      numbers_of_each[basket_item] += 1
    end
    grouped_basket = Hash.new()
    numbers_of_each.values.max.times do |x|
      grouped_basket[x] = []
    end
    basket.sort_by_frequency.reverse.each do |book|
      book_done = false
      grouped_basket.each do |groupNum, group|
        grouped_baskets_size = Array.new
        grouped_basket.values.each { |group| grouped_baskets_size << group.size }
        if (!group.include?(book) && !book_done)
          if group.size < 3 || (group.size == grouped_baskets_size.min)
            book_done = true
            grouped_basket[groupNum] << book
          end
        end
      end
    end
    grouped_basket
  end

  def discount(group)
    group_cost = group.size * @book_cost
    case group.size
    when 2
      group_cost * 0.95
    when 3
      group_cost * 0.9
    when 4
      group_cost * 0.8
    when 5
      group_cost * 0.75
    else
      group_cost
    end
  end
end
