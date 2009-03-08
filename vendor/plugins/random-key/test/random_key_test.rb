require 'test/unit'
require File.join(File.dirname(__FILE__), '../lib/random_key')

class BaseModel
  include RandomKey
  attr_accessor :id
  attr_accessor :key
  
  class << self
    attr_accessor :callback
  end

  def self.find(*args)
    nil
  end

  def self.before_create(method)
    self.callback = method
  end

  def save
    send(self.class.callback) if new_record?
    @id = 1
    self
  end
  
  def new_record?
    @id.nil?
  end
  
end

class MockModel < BaseModel
  has_random_key :key
end

class SizedMockModel < BaseModel
  KEY_SIZE = 20
  
  has_random_key :key, :size => KEY_SIZE
end

class NumericMockModel < BaseModel
  has_random_key :key, :include => :numbers
end

class DowncaseMockModel < BaseModel
  has_random_key :key, :include => :downcase
end

class UpcaseMockModel < BaseModel
  has_random_key :key, :include => :uppercase
end

class RandomPermalinkTest < Test::Unit::TestCase
  def test_should_create_random_key
    @m = MockModel.new
    
    assert         @m.save
    assert_not_nil @m.key
  end

  def test_should_create_sized_random_key
    @m = SizedMockModel.new
    
    assert         @m.save
    assert_not_nil @m.key
    assert_equal   SizedMockModel::KEY_SIZE, @m.key.length
  end

  def test_should_create_numeric_random_key
    @m = NumericMockModel.new
    
    assert            @m.save
    assert_not_nil    @m.key
    assert_not_equal  0, @m.key.to_i
  end

  def test_should_create_downcase_random_key
    @m = DowncaseMockModel.new
    
    assert          @m.save
    assert_not_nil  @m.key
    assert_equal    @m.key, @m.key.downcase
  end

  def test_should_create_upcase_random_key
    @m = UpcaseMockModel.new
    
    assert          @m.save
    assert_not_nil  @m.key
    assert_equal    @m.key, @m.key.upcase
  end
end
