require 'rubygems'
require 'sinatra'
require 'sequel'

helpers do
  def h(string)
    string.to_s.gsub('<','&lt;').
      gsub('>','&gt;').gsub('"', '&quot;')
  end
end

configure do
  Sequel.connect('sqlite://notes.db')

  class Note < Sequel::Model
    unless table_exists?
      set_schema do
        primary_key :id
        text :title
        text :body
      end
      create_table
    end
  end
end

get '/notes' do
  haml :index, :locals => {:notes => Note.all}
end

get '/notes/:id' do
  pass if params[:id] == 'new'
  haml(:show, :locals => {:note => Note[:id => params[:id]]}) +
    haml(:back_to_top)
end

get '/notes/new' do
  haml(:new, :locals => {:note => Note.new})+haml(:back_to_top)
end

get '/notes/:id/edit' do
  haml(:edit, :locals => {:note => Note[:id => params[:id]]}) +
    haml(:back_to_top)
end

put '/notes/:id' do
  note = Note.find(:id => params[:id])
  note.update(:title => params[:title], :body => params[:body])
  note.save
  redirect "/notes/#{params[:id]}"
end

post '/notes' do
  note = Note.new(:title => params[:title], :body => params[:body])
  note.save
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
      - notes.each do |note|
        %tr
          %td= h note.title
          %td 
            %a{:href => "/notes/#{note.id}"} show
          %td
            %a{:href => "/notes/#{note.id}/edit"} edit
  %a{:href => '/notes/new'} new note
@@ show
%h3= h note[:title]
%div= note[:body]
@@ edit
%form{:action => "/notes/#{note.id}", :method => "post"}
  %input{ :type => "hidden", :name => "_method", :value => "put"}
  = haml :form, :locals => {:note => note}
</form>
@@ new
%form{:action => "/notes", :method => "post"}
  = haml :form, :locals => {:note => note}
@@ form
%label{:for=>"title"} Description
%br
%input{:name=>"title", :value=>h(note.title), :size => 50}
%br
%label{:for => "body"}Content
%br
%textarea{:name => "body", :cols => 30, :rows => 10}= note.body
%br
%input{:type => "submit"}
@@ back_to_top
%div
  %a{ :href => "/notes"} Back to Top
