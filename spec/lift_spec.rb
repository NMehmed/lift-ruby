require './lib/cart.rb'

RSpec.describe "TotalCost" do
  cart = Cart.new

  it "should return 10 when 1 book is ordered" do
    expect(cart.calculate_cart_total(["H"])).to eq(10)
    expect(cart.calculate_cart_total(["F"])).to eq(10)
    expect(cart.calculate_cart_total(["T"])).to eq(10)
    expect(cart.calculate_cart_total(["R"])).to eq(10)
  end

  it "should return 20 when 2 copies of the same book are ordered" do
    expect(cart.calculate_cart_total(["H", "H"])).to eq(20)
  end

  it "shoud return 42 when combination of collection and and duplicate product is ordered" do
    expect(cart.calculate_cart_total(["F", "T", "R", "H", "H"])).to eq(42)
  end

  it "should return cheapest combination of collections" do
    expect(cart.calculate_cart_total(["F", "T", "H", "F", "T", "R"])).to eq(51)
  end
end