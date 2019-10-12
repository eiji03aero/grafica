require 'rails_helper'

RSpec.describe CreateScenarioService, type: :service do
  describe 'execute' do
    it 'should create' do
      name = 'test scenario'
      scenario = CreateScenarioService.new(name: name).execute
      expect(Scenario.find_by(id: scenario.id).name).to eq name
      expect(scenario.root_component).to be_an_instance_of Component
      expect(scenario.root_component.children.count).to eq 1
    end
  end
end
