Sequel.migration do
  up do
    create_table(:notes) do
      primary_key :id
      String :title, :text=>true
      String :body, :text=>true
    end
  end
  
  down do
    drop_table(:notes)
  end
end
