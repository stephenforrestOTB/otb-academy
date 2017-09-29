require "harry_potter.rb"
RSpec.describe "HP Bookshop" do
  let(:bookshop) {HarryPotter.new}
  it "can start with a book cost of 8GBP" do
    expect(bookshop.book_cost).to be(8.0)
  end
  it "can identify all harry potter books" do
    expect(bookshop.book_list).to eq([:first, :second, :third, :fourth, :fifth])
  end
  context "can sell" do
    it "single books" do
      basket = [:first]

      expect((bookshop.sell(basket)*100).to_i).to eq(800)
    end
    it "multiple books with discount" do
      basket = [:first, :second]

      expect((bookshop.sell(basket)*100).to_i).to eq(1520)
    end
    it "multiple books without discount" do
      basket = [:first, :first]

      expect((bookshop.sell(basket)*100).to_i).to eq(1600)
    end
    it "multiple books with and without discount" do
      basket = [:first, :first, :second]

      expect((bookshop.sell(basket)*100).to_i).to eq(2320)
    end
    it "multiple books with multiple discounts" do
      basket=[:first,:first,:second,:second,:third,:third,:fourth,:fifth]

      expect((bookshop.sell(basket)*100).to_i).to eq(5120)
    end
  end
  context "can sell hell orders" do
    it "one two three four" do
      basket=[:first,:second,:third,:fourth]

      expect((bookshop.sell(basket)*100).to_i).to eq(2560)
    end
    it "one two three four five" do
      basket=[:first,:second,:third,:fourth,:fifth]

      expect((bookshop.sell(basket)*100).to_i).to eq(3000)
    end
    it "one one two three" do
      basket=[:first,:second,:third,:first]

      expect((bookshop.sell(basket)*100).to_i).to eq(2960)
    end
    it "HARRY POTTER FANATIC" do
      basket=[:first,:first,:second,:second,:third,:third,:fourth,:fifth,:first,:first,:second,:second,:third,:third,:fourth,:fifth]

      expect((bookshop.sell(basket)*100).to_i).to eq(10240)
    end
    it "HARRY POTTER FANATIC  2" do
      basket=[:first,:first,:fifth,:second,:second,:third,:third,:fourth,:fifth,:first,:first,:second,:second,:third,:third,:fourth,:fifth]

      expect((bookshop.sell(basket)*100).to_i).to eq(10680)
    end
  end
end
