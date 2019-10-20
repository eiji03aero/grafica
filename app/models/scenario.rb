class Scenario
  include Neo4j::ActiveNode
  include Neo4j::Timestamps

  property :name, default: 'scenario'

  has_one :out, :root_component, type: :component, model_class: :Component

  def nodes
    DialogObject.where(scenario: self)
  end

  def number_of_nodes
    nodes.count
  end
end
