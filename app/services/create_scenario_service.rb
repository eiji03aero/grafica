class CreateScenarioService
  def initialize(name:)
    @name = name
  end

  def execute
    scenario = Scenario.create(name: @name)
    root_component = DialogObjectFactoryService.create(
      scenario_id: scenario.id, type: 'component'
    )
    start_node = DialogObjectFactoryService.create(
      scenario_id: scenario.id, type: 'start_node'
    )
    root_component.children << start_node
    scenario.root_component = root_component
    scenario
  end
end
