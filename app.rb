$:<< File.join(File.dirname(__FILE__), 'lib')

require 'rubygems'
require 'gitjour'
require 'supgitjour'
require 'sinatra'
require 'erb'
require 'haml'
require 'pp'

get '/' do
  @jours = Supgitjour.list
  haml :index
end

get '/list' do
  @jours = Supgitjour.list
  erb :list, :layout => false
end
