require "rails_helper"

RSpec.describe EndNode, type: :model do
  describe "#execute" do
    include_context "has scenario with text sequence"

    it "should return proper value" do
      node = CreateNodeService.execute(
        type: "end_node", scenario_id: scenario.id, parent_id: scenario.root_component.id
      )

      next_node, reply_data = node.execute(sequence)
      expect(next_node).to eq nil
      expect(reply_data.length).to be 0
    end
  end
end
