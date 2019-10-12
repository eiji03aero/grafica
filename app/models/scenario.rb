class Scenario
  include Neo4j::ActiveNode
  include Neo4j::Timestamps

  property :name, default: 'scenario'

  has_one :out, :root_component, type: :component, model_class: :Component

  after_create do
    initialize_properties
  end

  def initialize_properties
    self.root_component = Component.new
    root_component.children << StartNode.new
  end
end
