require 'rails_helper'

RSpec.describe CreateNodeService, type: :service do
  describe 'execute' do
    include_context "has brand new scenario"

    it 'should create' do
      tests = [
        {
          type: "component",
          class: Component,
          data: {}
        },
        {
          type: "start_node",
          class: StartNode,
          data: {}
        },
        {
          type: "end_node",
          class: EndNode,
          data: {}
        },
        {
          type: "text_node",
          class: TextNode,
          data: { text: "hoge" }
        },
        {
          type: "suspend_node",
          class: SuspendNode,
          data: {}
        },
        {
          type: "condition_node",
          class: ConditionNode,
          data: {}
        },
      ]

      tests.each do |t|
        node = CreateNodeService.execute(
          type: t[:type],
          data: t[:data],
          parent_id: scenario.root_component,
          scenario_id: scenario.id
        )
        expect(node).to be_an_instance_of t[:class]
      end
    end
  end
end
