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

  attr_reader :sequence, :client, :scenario, :conversation, :execute_count, :reply_messages, :current_node

  def initialize(params)
    @sequence = Sequence.find(params[:sequence_id])
    @client = @sequence.client
    @conversation = @sequence.conversation
    @scenario = @client.scenario
    @execute_count = 0
    @reply_messages = []
  end

  def execute
    init_current_node
    run_execute_loop
    reply_messages
  end

  private
  def init_current_node
    @current_node = FindNodeToStartService.execute(scenario_id: scenario.id, conversation_id: conversation.id)
  end

  def run_execute_loop
    while true
      @execute_count += 1
      if @execute_count > Scenario::MAX_LOOP_COUNT
        raise ScenarioError::ScenarioInfiniteLoop
      end

      if Scenario.should_stop?(current_node)
        break
      end

      next_node, reply_data = current_node.execute(sequence)

      if reply_data.is_a?(Array)
        @reply_messages += reply_data
      end

      @current_node = next_node
    end
  end
end
