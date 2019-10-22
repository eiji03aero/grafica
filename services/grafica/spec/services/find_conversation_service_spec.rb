require 'rails_helper'

RSpec.describe FindConversationService, type: :service do
  describe '#execute' do
    include_context "has brand new scenario"
    let!(:client) { Client.create }

    before :each do
      scenario.clients << client
    end

    it 'should create conversation if not existed' do
      conversation = FindConversationService.execute(client_id: client.id, scenario_id: scenario.id)
      expect(conversation).to be_an_instance_of Conversation
      expect(conversation).to be_persisted
    end

    it 'should fetch conversation if existed' do
      conversation = FindConversationService.execute(client_id: client.id, scenario_id: scenario.id)
      fetched_conversation = FindConversationService.execute(client_id: client.id, scenario_id: scenario.id)
      expect(fetched_conversation.id).to eq conversation.id
    end

    it 'should create conversation if last is finished' do
      conversation = FindConversationService.execute(client_id: client.id, scenario_id: scenario.id)
      conversation.finish!
      fetched_conversation = FindConversationService.execute(client_id: client.id, scenario_id: scenario.id)
      expect(fetched_conversation.id).not_to eq conversation.id
    end
  end
end
