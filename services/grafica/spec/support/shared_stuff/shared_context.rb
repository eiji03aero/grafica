shared_context "has brand new scenario" do
  let!(:scenario) { CreateScenarioService.execute(name: "scenario") }
end

shared_context "has scenario and basis" do
  include_context "has brand new scenario"
  let!(:client) { Client.create }
  let!(:conversation) { FindConversationService.execute(client_id: client.id, scenario_id: scenario.id) }
  before :each do
    scenario.clients << client
  end
end

shared_context "has scenario with text sequence" do |text = "hoge"|
  include_context "has scenario and basis"
  let!(:sequence) { Sequence.create(text: text, client: client, conversation: conversation) }
end
