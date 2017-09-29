require 'pub_finder.rb'
RSpec.describe "The almighty pub finder" do
  let(:finder){ PubFinder.new }
  it "should find pubs around a postcode area" do
    expect(finder.find_in("m20 4sh")).to eq(33)
  end
end
