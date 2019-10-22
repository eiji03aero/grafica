class ScenarioError::Base
  include Neo4j::ActiveNode
  include Neo4j::Timestamps

    self.mapped_label_name = "Condition::Base"

  has_many :out, :related_nodes, type: :related_nodes, model_class: :dialog_object
end
