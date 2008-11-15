require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

describe "/gitjours" do
  before(:each) do
    @response = request("/gitjours")
  end
end