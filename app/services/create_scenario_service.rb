class CreateScenarioService
  extend ServiceModule::Base

  attr_accessor :scenario

  def initialize(name:)
    @name = name
  end

  def execute
    @scenario = Scenario.create(name: @name)
    init_root_component
    init_client_bot
    @scenario
  end

  def init_root_component
    root_component = DialogObjectFactoryService.execute(
      scenario_id: scenario.id, type: 'component'
    )
    start_node = DialogObjectFactoryService.execute(
      scenario_id: scenario.id, type: 'start_node', parent_id: root_component.id
    )
    @scenario.root_component = root_component
  end

  def init_client_bot
    client_bot = Client.create(type: :bot)
    @scenario.clients << client_bot
  end
end
