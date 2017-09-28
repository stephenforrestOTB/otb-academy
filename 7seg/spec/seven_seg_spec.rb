require "seven_seg.rb"

RSpec.describe "the seven segment display" do
  it "can print 1234567890 normal" do
    big = SevenSeg.new(1234567890)
    expect(big.printify).to eq ( "    _  _     _  _  _  _  _  _ \n  | _| _||_||_ |_   ||_||_|| |\n  ||_  _|  | _||_|  ||_| _||_|")
  end
  it "can print 1234567890 large" do
    big = SevenSeg.new(1234567890)
    expect(big.printify(2,2)).to eq ("     __  __      __  __  __  __  __  __ \n   |   |   ||  ||   |      ||  ||  ||  |   | __| __||__||__ |__    ||__||__||  |\n   ||      |   |   ||  |   ||  |   ||  |   ||__  __|   | __||__|   ||__| __||__|")
  end
  it "can print a huge 1234" do
    big = SevenSeg.new(1234)
    expect(big.printify(4,4)).to eq ("       ____  ____       \n     |     |     ||    |     |     |     ||    |     |     |     ||    |     | ____| ____||____|\n     ||          |     |     ||          |     |     ||          |     |     ||____  ____|     |")
  end


end
