class CreateSequence < Neo4j::Migrations::Base
  def up
    add_constraint :Sequence, :uuid
  end

  def down
    drop_constraint :Sequence, :uuid
  end
end
