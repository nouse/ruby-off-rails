require 'sinatra'
require 'slim'
$LOAD_PATH << File.dirname(__FILE__)+"/lib"
require 'text_helpers'
require 'note'
require 'forme/sinatra'
require 'forme'

configure :development do
  set :slim, :pretty => true
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
  @forme = Forme::Form.new(Note.new)
  slim(:new)
end

get '/notes/:id/edit' do |id|
  @forme = Forme::Form.new Note[:id => id]
  slim(:edit)
end

put '/notes/:id' do |id|
  note = Note[:id => id]
  note.update params[:note]
  redirect "/notes/#{id}"
end

post '/notes' do
  @note = Note.create params[:note]
  redirect "/notes"
end

delete '/notes/:id' do |id|
  @note = Note[:id => id]
  @note.destroy
  redirect "/notes"
end
