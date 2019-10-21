class DialogObjectFactoryService
  extend ServiceModule::Base

  attr_accessor :node
  attr_reader :scenario, :parent_node, :type, :data

  def initialize(params)
    @scenario = Scenario.find(params[:scenario_id])
    @parent_node = Component.find(params.fetch(:parent_id)) if params[:parent_id]
    @type = params[:type]
    @data = params[:data]
  end

  def execute
    @node = create_node
    @node
  end

  private
  def create_node
    case type
    when "component"
      Component.create(base_params)
    when "start_node"
      StartNode.create(base_params)
    when "end_node"
      EndNode.create(base_params)
    when "text_node"
      TextNode.create(base_params(text: data[:text]))
    when "suspend_node"
      SuspendNode.create(base_params)
    when "condition_node"
      ConditionNode.create(base_params)
    else
      raise StandardError
    end
  end

  def base_params(params = {})
    params.merge(
      parent_node: parent_node,
      scenario: scenario
    )
  end
end
