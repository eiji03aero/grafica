class CreateScenarioService
  def initialize(params)
    @name = params[:name]
  end

  def execute
    scenario = Scenario.create(name: @name)
    scenario
  end
end
