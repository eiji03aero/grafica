# attributes
# - client
# - sequence
# - reply_messages
# - scenario
# - conversation
# - current_node
# - previous_node
# flow
# - initialize
#   - receive params
#     - sequence_id
#   - fetch corresponding sequence, scenario, client, conversation
# - execute
#   - find node to start
#     - set current_node to node to start
#   - while !Scenario.shouldStop(@current_node)
#     - message, next_node_id = @current_node.execute
#   - update conversation
#     - suspended_node_id
#   - normalize reply_messages
#     - compact
#   - return: reply_messages

class ExecuteScenarioService
  extend ServiceModule::Base

  attr_reader :sequence, :client, :scenario, :conversation

  def initialize(params)
    @sequence = Sequence.find(params[:sequence_id])
    @client = @sequence.client
    @conversation = @sequence.conversation
    @scenario = @client.scenario
  end

  def execute
    @current_node = FindNodeToStartService.execute(scenario_id: scenario.id, conversation_id: conversation.id)
  end
end
