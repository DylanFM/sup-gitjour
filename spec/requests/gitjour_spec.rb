require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

describe "/gitjour" do
  before(:each) do
    @response = request("/gitjour")
  end
end