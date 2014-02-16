require 'spec_helper'

describe Conversion do
  before(:each) do
    @dummy_class = Class.new
    @dummy_class.extend(Conversion)
  end
  
  it "converts characters into numbers" do
    @dummy_class.convert_to_letters(1).should == "A"
  end

  it "converts numbers into characters" do
    @dummy_class.convert_to_numbers("A").should == 1
  end  
end