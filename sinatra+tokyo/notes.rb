require 'rubygems'
require 'sinatra'
require 'rufus/edo'
require 'uuidtools'

helpers do
  def h(string)
    string.to_s.gsub('<','&lt;').
      gsub('>','&gt;').gsub('"', '&quot;')
  end
end

configure do
  DB = Rufus::Edo::Table.new('data.tct')
end

get '/notes' do
  @notes = DB.query{|q| q.add 'table', :eq, 'blogs'}.map{|b|b}
  haml :index
end

get '/notes/:id' do
  pass if params[:id] == 'new'
  @note = DB['blogs_' + params[:id]]
  haml(:show) + haml(:back_to_top)
end

get '/notes/new' do
  @note = {'title' => '', 'body' => ''}
  haml(:new) + haml(:back_to_top)
end

get '/notes/:id/edit' do
  @note = DB['blogs_' + params[:id]]
  haml(:edit) + haml(:back_to_top)
end

put '/notes/:id' do
  DB['blogs_'+params[:id]] = {'title' => params[:title], 'body' => params[:body], 'table' => 'blogs'}
  redirect "/notes/#{params[:id]}"
end

post '/notes' do
  uuid = UUID.random_create.to_s
  DB['blogs_'+uuid] = {'title' => params[:title], 'body' => params[:body], 'table' => 'blogs'}
  redirect "/notes"
end
