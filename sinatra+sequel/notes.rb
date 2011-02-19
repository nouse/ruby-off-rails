require 'sinatra'
require 'sequel'
require 'haml'

module TextHelper
  def h(string)
    Rack::Utils.escape_html(string)
  end
  def truncate(text, length=20)
    max_length = length.abs
    text.length > max_length ? "#{text[0..max_length]}..." : text
  end
end

helpers TextHelper

configure do
  DB.create_table?(:notes) do
    primary_key :id
    text :title
    text :body
  end

  class Note < Sequel::Model
  end
end

get '/' do
  redirect '/notes'
end

get '/notes' do
  @notes = Note.all
  haml :index
end

get '/notes/:id' do |id|
  pass if id == 'new'
  @note = Note[:id => id]
  haml(:show)
end

get '/notes/new' do
  @note = Note.new
  haml(:new)
end

get '/notes/:id/edit' do |id|
  @note = Note[:id => id]
  haml(:edit)
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
