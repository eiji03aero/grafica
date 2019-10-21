class DialogObject
  include Neo4j::ActiveNode
  include Neo4j::Timestamps

  property :sequential_id, type: Integer, default: 0

  has_one :out, :parent_node, type: :parent_node, model_class: :DialogObject
  has_one :out, :next_node, type: :dialog_object, model_class: :DialogObject
  has_one :out, :scenario, type: :scenario_belonging, model_class: :Scenario

  before_create do
    # sequential_id starts from 0
    self.sequential_id = scenario.number_of_nodes
  end
end
