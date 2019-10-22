class CreateScenario < Neo4j::Migrations::Base
  def up
    add_constraint :Scenario, :uuid
  end

  def down
    drop_constraint :Scenario, :uuid
  end
end
