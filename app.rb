$:<< File.join(File.dirname(__FILE__), 'lib')

require 'rubygems'
require 'gitjour'
require 'supgitjour'
require 'sinatra'
require 'erb'
require 'haml'

get '/' do
  @jours = get_jours
  haml :index
end

get '/list' do
  @jours = get_jours
  erb :list, :layout => false
end

helpers do
  def get_jours
    jour = Supgitjour.new
    jour.request
    jour.response
  end
end
