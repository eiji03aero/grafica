require 'rails_helper'

RSpec.describe CreateScenarioService, type: :service do
  describe 'execute' do
    it 'should create' do
      name = 'test scenario'
      scenario = CreateScenarioService.execute(name: name)
      expect(Scenario.find_by(id: scenario.id).name).to eq name
      expect(scenario.root_component).to be_an_instance_of Component
      expect(scenario.root_component.children.count).to eq 1
      expect(scenario.clients.first).to be_an_instance_of Client
      expect(scenario.clients.first.bot?).to be_truthy
    end
  end
end
