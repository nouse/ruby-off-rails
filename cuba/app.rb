require 'cuba'
require 'cuba/render'
require 'slim'

class Note < Ohm::Model
  attribute :title
  attribute :body

  class << self
    def count
      all.size
    end
  end
end

Cuba.plugin Cuba::Render
Cuba.plugin TextHelpers
Cuba.use Rack::MethodOverride

Cuba.settings[:template_engine] = "slim"
Cuba.define do
  on get, "notes/new" do
    res.write view("new")
  end

  on "notes/:id" do |id|
    note = Note[id]
    on get do
      on root do
        res.write view("show", note: note)
      end

      on "edit" do
        res.write view("edit", note: note)
      end
    end

    on put, param("note") do |attrs|
      note.update attrs
      res.redirect "/notes/#{note.id}"
    end
      
    on delete do
      note.delete
      res.redirect "/notes"
    end
  end
  on get do
    on root do
      res.redirect "/notes"
    end

    on "notes" do
      res.write view("index", notes: Note.all)
    end
  end

  on post do
    on "notes", param("note") do |attrs|
      Note.create attrs
      res.redirect "/notes"
    end
  end

end
