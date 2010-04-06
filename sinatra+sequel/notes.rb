# run gem install sinatra sequel haml amalgalite first
require 'rubygems'
require 'sinatra'
require 'sequel'
require 'haml'

helpers do
  def h(string)
    string.to_s.gsub('<','&lt;').
      gsub('>','&gt;').gsub('"', '&quot;')
  end
end

configure do
  DB = Sequel.connect('amalgalite://notes.db')
  DB.create_table?(:notes) do
    primary_key :id
    text :title
    text :body
  end
  class Note < Sequel::Model
  end
end

get '/notes' do
  @notes = Note.all
  haml :index
end

get '/notes/:id' do |id|
  pass if id == 'new'
  @note = Note[:id => id]
  haml(:show) + haml(:back_to_top)
end

get '/notes/new' do
  @note = Note.new
  haml(:new)+haml(:back_to_top)
end

get '/notes/:id/edit' do |id|
  @note = Note[:id => id]
  haml(:edit) +
    haml(:back_to_top)
end

put '/notes/:id' do |id|
  note = Note.find(:id => id)
  note.update(:title => params[:title], :body => params[:body])
  note.save
  redirect "/notes/#{id}"
end

post '/notes' do
  note = Note.new(:title => params[:title], :body => params[:body])
  note.save
  redirect "/notes"
end

delete '/notes/:id' do |id|
  note = Note.find(:id => id)
  note.destroy
  redirect "/notes"
end

__END__
@@ layout
%html
  %head
    %title note in sinatra
  %body= yield
@@ index
%div.body
  %table{:width => "100%", :style => "border-collapse: collapse", :border => 1}
    %thead
      %tr 
        %td title
        %td &nbsp;
        %td &nbsp;
    %tbody
      - @notes.each do |note|
        %tr
          %td= h note.title
          %td 
            %a{:href => "/notes/#{note.id}"} show
          %td
            %a{:href => "/notes/#{note.id}/edit"} edit
  %a{:href => '/notes/new'} new note
@@ show
%h3= h @note[:title]
%div= @note[:body]
@@ edit
%form{:action => "/notes/#{@note.id}", :method => "post"}
  %input{ :type => "hidden", :name => "_method", :value => "put"}
  = haml :form
%form{:action => "/notes/#{@note.id}", :method => "post"}
  %input{ :type => "hidden", :name => "_method", :value => "delete"}
  %input{ :type => "submit", :value => 'delete'}/
@@ new
%form{:action => "/notes", :method => "post"}
  = haml :form
@@ form
%label{:for=>"title"} Description
%br
%input{:name=>"title", :value=>h(@note.title), :size => 50}
%br
%label{:for => "body"}Content
%br
%textarea{:name => "body", :cols => 30, :rows => 10}= @note.body
%br
%input{:type => "submit"}
@@ back_to_top
%div
  %a{ :href => "/notes"} Back to Top
