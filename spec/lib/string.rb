require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe String do
  describe "^" do
    it "should XOR a string and back" do
      (("foo" ^ "bar") ^ "bar").should == 'foo'
    end
    
    it "should XOR a long string and back" do
      string = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
      ((string ^ "bar") ^ "bar").should == string
    end
  end
end
