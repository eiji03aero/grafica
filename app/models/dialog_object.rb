class DialogObject
  include Neo4j::ActiveNode
  include Neo4j::Timestamps

  has_one :both, :parent_node, type: :dialog_object, model_class: :DialogObject
  has_one :out, :next_node, type: :dialog_object, model_class: :DialogObject
end
