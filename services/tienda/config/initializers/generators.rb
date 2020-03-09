Rails.application.config.generators do |g|
  g.javascripts false
  g.stylesheets false
  g.helper false
  g.jbuilder false
  g.orm :mongoid
  g.test_framework :rspec,
    fixture: true,
    view_specs: false,
    helper_specs: false,
    routing_specs: false,
    controller_specs: true,
    request_specs: true
end
