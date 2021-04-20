require './lib/calculator.rb'

describe Calculator do
  describe "#add" do
    it "returns the sum of two numbers" do
      calculator = Calculator.new
      expect(calculator.add(5, 2)).to eql(7)
    end

    it "returns the sum of more than two numbers" do
      calculator = Calculator.new
      expect(calculator.add(5, 2, 7)).to eql(14)
    end

  end

  describe "multiply" do
    it "multiply two numbers " do
      calculator = Calculator.new
      expect(calculator.multiply(2, 3)).to eql (6)
    end

    it "multiply more than two numbers" do
      calculator = Calculator.new
      expect(calculator.multiply(2, 3, 4)).to eql(24)
    end

  end


end