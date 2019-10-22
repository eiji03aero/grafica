require "rails_helper"

RSpec.describe TextNode, type: :model do
  describe "#execute" do
    include_context "has scenario with text sequence"

    it "should return proper value" do
      test_text = "test text"
      node = CreateNodeService.execute(
        type: "text_node", scenario_id: scenario.id, parent_id: scenario.root_component.id, data: { text: test_text}
      )
      node2 = CreateNodeService.execute(
        type: "end_node", scenario_id: scenario.id, parent_id: scenario.root_component.id
      )
      node.update(next_node: node2)

      next_node, reply_data = node.execute(sequence)
      expect(next_node.id).to eq node2.id
      expect(reply_data.length).to be 1
      expect(reply_data[0][:text]).to eq test_text
    end
  end
end
