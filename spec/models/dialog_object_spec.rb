require 'rails_helper'

RSpec.describe DialogObject, type: :model do
  describe 'basic' do
    it 'should have incremental sequential_id' do
      scenario = CreateScenarioService.new(name: 'test scenario').execute
      do1 = DialogObject.create(parent_node: scenario.root_component, scenario: scenario)
      do2 = DialogObject.create(parent_node: scenario.root_component, scenario: scenario)
      expect(do1.sequential_id).to eq 2
      expect(do2.sequential_id).to eq 3
    end
  end
end
