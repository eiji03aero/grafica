# attributes
# - client
# - scenario
# - conversation
# flow
# - initialize
#   - receive params
#     - client_id
#     - scenario_id
#   - fetch client
#   - fetch scenario
# - execute
#   - find latest conversation
#   - if state is on_going
#     - return: Conversation
#   - elsif state is finished
#     - create Conversation
#     - add current client and client_bot
#     - return: Conversation
class FindConversationService
  extend ServiceModule::Base

  attr_accessor :client, :scenario, :conversation

  def initialize(params)
    @client = Client.find(params[:client_id])
    @scenario = Scenario.find(params[:scenario_id])
  end

  def execute
    @conversation = find_or_initialize_conversation
    @conversation
  end

  def find_or_initialize_conversation
    last_conversation = @client.conversations.last

    if last_conversation&.state_running?
      return last_conversation
    end

    conversation = Conversation.create
    conversation.clients << @client
    conversation.clients << @scenario.client_bot
    return conversation
  end
end
