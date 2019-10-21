class Sequence
  include Neo4j::ActiveNode
  include Neo4j::Timestamps

  property :text

  has_one :out, :client, type: :client, model_class: :Client
  has_one :out, :conversation, type: :conversation, model_class: :Conversation
end
