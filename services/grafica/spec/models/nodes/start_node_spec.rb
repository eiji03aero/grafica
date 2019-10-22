require "rails_helper"

RSpec.describe StartNode, type: :model do
  describe "#execute" do
    include_context "has scenario with text sequence"

    it "should return proper value" do
      node = CreateNodeService.execute(
        type: "start_node", scenario_id: scenario.id, parent_id: scenario.root_component.id
      )
      node2 = CreateNodeService.execute(
        type: "end_node", scenario_id: scenario.id, parent_id: scenario.root_component.id
      )
      node.update(next_node: node2)

      next_node, reply_data = node.execute(sequence)
      expect(next_node.id).to eq node2.id
      expect(reply_data.length).to be 0
    end
  end
end
