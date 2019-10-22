class Scenario
  include Neo4j::ActiveNode
  include Neo4j::Timestamps

  property :name, default: 'scenario'

  has_one :out, :root_component, type: :component, model_class: :Component
  has_many :in, :nodes, type: :scenario_belonging, model_class: :DialogObject
  has_many :in, :clients, type: :scenario, model_class: :Client

  MAX_LOOP_COUNT = 100

  class << self
    def should_stop?(node)
      is_suspend = node.is_a?(SuspendNode)
      is_root_end = node.is_a?(EndNode) && node.parent_node == root_component
      is_suspend || is_root_end
    end
  end

  def number_of_nodes
    nodes.count
  end

  def client_bot
    clients.bot.first
  end

  def root_start_node
    root_component.children.start_nodes.first
  end
end
