class Component < DialogObject
  property :name, default: ''

  has_many :both, :children, type: :dialog_object, model_class: :DialogObject
end
