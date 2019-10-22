require 'rails_helper'

RSpec.describe Condition::TextPerfectMatch, type: :model do
  include_context 'has scenario and basis'
  let!(:condition_node) { CreateNodeService.execute(type: 'condition_node', scenario_id: scenario.id, parent_id: scenario.root_component.id )}

  describe '#calc_confidence' do
    it 'should not match when input is not perfect match' do
      sequence = Sequence.create(text: 'hoge', client: client, conversation: conversation)
      condition = Condition::TextPerfectMatch.create(text: 'domo')
      result = condition.calc_confidence(sequence)
      expect(result).to be Condition::Score::NO_MATCH
    end

    it 'should match when input is perfect match' do
      sequence = Sequence.create(text: 'hoge', client: client, conversation: conversation)
      condition = Condition::TextPerfectMatch.create(text: 'hoge')
      result = condition.calc_confidence(sequence)
      expect(result).to be Condition::Score::MATCH
    end
  end
end
