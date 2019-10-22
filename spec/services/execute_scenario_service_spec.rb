require 'rails_helper'

RSpec.describe ExecuteScenarioService, type: :service do
  include_context 'has scenario and basis'
  let!(:start_node) {
    scenario.root_component.children.first
  }
  let!(:text1) { CreateNodeService.execute(
    type: 'text_node', scenario_id: scenario.id, parent_id: scenario.root_component.id, data: { text: 'domo1' }
  )}
  let!(:text2) { CreateNodeService.execute(
    type: 'text_node', scenario_id: scenario.id, parent_id: scenario.root_component.id, data: { text: 'domo2' }
  )}
  let!(:suspend) { CreateNodeService.execute(
    type: 'text_node', scenario_id: scenario.id, parent_id: scenario.root_component.id, data: { text: 'domo2' }
  )}

  describe '.execute' do
    it 'should return texts' do
      start_node.next_node = text1
      text1.next_node = text2
      text2.next_node = suspend

      sequence = Sequence.create(text: 'hoge', client: client, conversation: conversation)
      reply_messages = ExecuteScenarioService.execute(sequence_id: sequence.id)

      expect(reply_messages.length).to eq 2
      expect(reply_messages[0].text).to eq "domo1"
      expect(reply_messages[1].text).to eq "domo2"
    end
  end
end
