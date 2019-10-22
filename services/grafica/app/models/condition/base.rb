module Condition
  module Score
    NO_MATCH = 0
    MATCH = 1
    ABSOLUTE_MATCH = 10
  end

  class Base
    include Neo4j::ActiveNode
    include Neo4j::Timestamps

    self.mapped_label_name = "Condition::Base"

    has_one :in, :node, type: :conditions, model_class: :ConditionNode
    has_one :out, :next_node, type: :next_node, model_class: :DialogObject

    def calc_confidence(sequence)
      Score::NO_MATCH
    end
  end
end
