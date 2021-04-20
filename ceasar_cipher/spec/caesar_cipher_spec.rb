require './ceasar.rb'

describe ceasar('',1) do
  describe "#simple text" do
    it "simple lowercase text" do
      expect(ceasar('abc',1)).to eql('bcd')
    end

    it "simple upper text" do
      expect(ceasar('Abc',2)).to eql('Cde')
    end

    it "wrap around + " do
      expect(ceasar('Zhy',2)).to eql('Bja')
    end

    it "wrap around - " do
      expect(ceasar('Abc', -2)).to eql('Yza')
    end

    it "large shift " do
      expect(ceasar('Abc', -72)).to eql('Ghi')
    end

    it "special characters ignored " do
      expect(ceasar('!A*b@c#', -2)).to eql('!Y*z@a#')
    end

  end
end