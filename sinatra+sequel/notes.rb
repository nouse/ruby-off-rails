require 'sinatra'
require 'sequel'
require 'slim'
$LOAD_PATH << File.dirname(__FILE__)+"/lib"
require 'text_helpers'

configure :development do
  set :slim, :pretty => true
end

configure do
  DB.create_table?(:notes) do
    primary_key :id
    text :title
    text :body
  end

  class Note < Sequel::Model
  end
end

helpers TextHelpers

get '/' do
  redirect '/notes'
end

get '/notes' do
  @notes = Note.all
  slim :index
end

get '/notes/:id' do |id|
  pass if id == 'new'
  @note = Note[:id => id]
  slim(:show)
end

get '/notes/new' do
  @note = Note.new
  slim(:new)
end

get '/notes/:id/edit' do |id|
  @note = Note[:id => id]
  slim(:edit)
end

put '/notes/:id' do |id|
  note = Note[:id => id]
  note.update(:title => params[:title], :body => params[:body])
  redirect "/notes/#{id}"
end

post '/notes' do
  @note = Note.create(:title => params[:title], :body => params[:body])
  redirect "/notes"
end

delete '/notes/:id' do |id|
  @note = Note[:id => id]
  @note.destroy
  redirect "/notes"
end
