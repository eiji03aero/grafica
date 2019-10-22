class FindNodeToStartService
  extend ServiceModule::Base

  def initialize(params)
    @scenario = Scenario.find(params[:scenario_id])
    @conversation = Conversation.find(params[:conversation_id])
  end

  def execute
    suspended_node = @conversation.suspended_node

    return suspended_node.next_node if suspended_node

    @scenario.root_start_node
  end
end
