require "rails_helper"

RSpec.describe ConditionNode, type: :model do
  include_context 'has scenario with text sequence', "condition node test"
  let!(:condition_node) { CreateNodeService.execute(type: 'condition_node', scenario_id: scenario.id, parent_id: scenario.root_component.id )}
  let!(:condition) { Condition::TextPerfectMatch.create(text: 'hoge') }

  describe '#add_condition' do
    it 'should add new condition' do
      condition_node.add_condition(condition)
      expect(condition_node.conditions.pluck(:id)).to include condition.id
    end
  end

  describe '#update_condition' do
    it 'should update condition' do
      update_text = 'domo'
      condition_node.add_condition(condition)
      condition_node.update_condition(condition.id, {text: update_text})
      expect(condition_node.conditions.last.text).to eq update_text
    end
  end

  describe '#destroy_condition' do
    it 'should destroy condition' do
      condition_node.add_condition(condition)
      condition_node.destroy_condition(condition.id)
      expect(condition_node.conditions.length).to eq 0
    end
  end

  describe "#execute" do
    it "should return matched conditions next_node" do
      node = CreateNodeService.execute(
        type: "end_node", scenario_id: scenario.id, parent_id: scenario.root_component.id
      )
      condition = Condition::TextPerfectMatch.create(text: 'condition node test', next_node: node)
      condition_node.add_condition(condition)

      next_node, reply_data = condition_node.execute(sequence)
      expect(next_node.id).to eq node.id
      expect(reply_data.length).to be 0
    end
  end
end
