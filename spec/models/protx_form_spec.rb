require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ProtxForm do
  before(:each) do
    @protx = ProtxForm.new(:encryption_key => 'foo', :app_key => 'testapp')
  end
  
  describe 'encrypting/decrypting' do
    def perform_encrypt_decrypt(hash)
      crypt = @protx.send(:encrypt_for_protx, hash)
      @protx.send(:decrypt_from_protx, crypt)
    end
    
    it "should work on a small hash" do
      hash = { 'foo' => 'bar' }
      perform_encrypt_decrypt(hash).should == hash
    end
    
    it "should work on a real Protx hash" do
      hash = {
        "Status"=>"OK", "VPSTxId"=>"{D89F4C3B-6FA8-4DC1-BB2E-8653AA3FACB6}", 
        "VendorTxCode"=>"livro.lan-bricks-14", "StatusDetail"=>"Successfully Authorised Transaction", 
        "GiftAid"=>"0", "AVSCV2"=>"ALL MATCH", "Amount"=>"10", "TxAuthNo"=>"7349", 
        "CAVV"=>"MN3K9KDW22ENJLARAGIXDK", "3DSecureStatus"=>"OK", "CV2Result"=>"MATCHED", 
        "PostCodeResult"=>"MATCHED",  "AddressResult"=>"MATCHED"
      }
      perform_encrypt_decrypt(hash).should == hash
    end
    
    it "should work on a real Protx hash with a long string" do
      string = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
      hash = {
        "Status"=>"OK", "VPSTxId"=>"{D89F4C3B-6FA8-4DC1-BB2E-8653AA3FACB6}", 
        "VendorTxCode"=>"livro.lan-bricks-14", "StatusDetail"=>"Successfully Authorised Transaction", 
        "GiftAid"=>"0", "AVSCV2"=>"ALL MATCH", "Amount"=>"10", "TxAuthNo"=>"7349", 
        "CAVV"=>"MN3K9KDW22ENJLARAGIXDK", "3DSecureStatus"=>"OK", "CV2Result"=>"MATCHED", 
        "PostCodeResult"=>"MATCHED",  "AddressResult"=>"MATCHED", "foo" => string
      }
      perform_encrypt_decrypt(hash).should == hash
    end
  end
  
  describe "object details for a brick" do
    before(:each) do
      @brick = Brick.create(:value => 250, :first_name => 'first', :last_name => 'last')
      @object_details = @protx.send(:object_details, @brick, 'success', 'failure')
    end
    
    it "should set the vendor tx code to use the brick url key" do
      @object_details['VendorTxCode'].should == "testapp-bricks-#{@brick.id}"
    end
  end
  
  describe 'parsing Protx result' do
    
  end
end
