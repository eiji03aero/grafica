class CreateDialogObject < Neo4j::Migrations::Base
  def up
    add_constraint :DialogObject, :uuid
  end

  def down
    drop_constraint :DialogObject, :uuid
  end
end
