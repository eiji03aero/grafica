class Client
  include Neo4j::ActiveNode
  include Neo4j::Timestamps

  enum type: [:user, :bot], _default: :user

  has_one :out, :scenario, type: :scenario, model_class: :Scenario
  has_many :in, :conversations, type: :clients, model_class: :Conversation
  has_many :in, :sequences, type: :client, model_class: :Sequence

end
