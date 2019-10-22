class CreateBase < Neo4j::Migrations::Base
  def up
    add_constraint "ScenarioError::Base", :uuid
  end

  def down
    drop_constraint "ScenarioError::Base", :uuid
  end
end
