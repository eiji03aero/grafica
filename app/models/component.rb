class Component < DialogObject
  property :name, default: ''

  has_many :in, :children, type: :parent_node, model_class: :DialogObject
end
