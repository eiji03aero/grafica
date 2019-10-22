class ConditionNode < Node
  has_many :out, :conditions, type: :conditions, model_class: "Condition::Base"

  def get_next_node(sequence)
    condition = calc_conditions(sequence)
    condition.next_node
  end

  def calc_conditions(sequence)
    result = conditions
      .to_a
      .inject({absolute_match: [], match: []}) do |accum, cur|
        case cur.calc_confidence(sequence)
        when Condition::Score::ABSOLUTE_MATCH
          accum[:aboslute_match].push(cur)
        when Condition::Score::MATCH
          accum[:match].push(cur)
        end
        accum
      end

    return result[:absolute_match][0] || result[:match][0]
  end

  def add_condition(condition)
    conditions << condition
  end

  def update_condition(id, data)
    condition = conditions.find(id)
    condition.update(data)
  end

  def destroy_condition(condition_id)
    condition = conditions.find(condition_id)
    condition.destroy
  end
end
