class CreateClient < Neo4j::Migrations::Base
  def up
    add_constraint :Client, :uuid
    add_index :Client, :type, force: true
  end

  def down
    drop_constraint :Client, :uuid
    drop_index :Client, :type
  end
end
