require 'rails_helper'

RSpec.describe FindNodeToStartService, type: :service do
  describe '.execute' do
    include_context 'has scenario and basis'
    let!(:suspend_node) { }

    it 'should return start_node on root_component when there is no suspended node on conversation' do
      start_node = scenario.root_start_node
      conversation.suspended_node = nil

      result = FindNodeToStartService.execute(scenario_id: scenario.id, conversation_id: conversation.id)
      expect(result.id).to eq start_node.id
    end

    it 'should return next_node of conversations suspended_node' do
      suspend_node = CreateNodeService.execute(
        type: 'suspend_node', scenario_id: scenario.id, parent_id: scenario.root_component.id
      )
      next_node = CreateNodeService.execute(
        type: 'text_node', scenario_id: scenario.id, parent_id: scenario.root_component.id, data: { text: 'hoge' }
      )
      suspend_node.next_node = next_node
      conversation.suspended_node = suspend_node
      result = FindNodeToStartService.execute(scenario_id: scenario.id, conversation_id: conversation.id)
      expect(result.id).to eq next_node.id
    end
  end
end
