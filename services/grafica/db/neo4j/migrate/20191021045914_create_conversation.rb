class CreateConversation < Neo4j::Migrations::Base
  def up
    add_constraint :Conversation, :uuid
    add_index :Conversation, :type, force: true
  end

  def down
    drop_constraint :Conversation, :uuid
    drop_index :Conversation, :type
  end
end
