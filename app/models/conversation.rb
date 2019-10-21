class Conversation
  include Neo4j::ActiveNode
  include Neo4j::Timestamps

  enum type: [:running, :finished], _default: :running, _prefix: :state

  has_many :out, :clients, type: :clients, model_class: :Client
  has_many :in, :sequences, type: :conversation, model_class: :Sequence

  def finish!
    state_finished!
    save
  end
end
