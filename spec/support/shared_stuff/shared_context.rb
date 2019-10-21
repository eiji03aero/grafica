shared_context "has brand new scenario" do
  let!(:scenario) { CreateScenarioService.execute(name: 'scenario') }
end
