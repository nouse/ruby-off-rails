require 'rubygems'
require 'sinatra'
require 'haml'
require 'sass'
require 'cloudkit'

class Tasks < Sinatra::Default
  
  use CloudKit::Service, :collections => [:tasks]
  
  get '/' do
    haml :index
  end
  
  get '/stylesheets/:sheet.css' do
    sass :"#{params['sheet']}"
  end

  get '/templates/:template' do
    html = haml(params[:template].to_sym, :views => './views/templates')
    html.gsub('&lt;','<').gsub('&gt;','>')
  end
end
