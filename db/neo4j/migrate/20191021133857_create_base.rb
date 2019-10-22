class CreateBase < Neo4j::Migrations::Base
  def up
    add_constraint "Condition::Base", :uuid
  end

  def down
    drop_constraint "Condition::Base", :uuid
  end
end
