require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module Ticketee
  class Application < Rails::Application
    config.generators do |g|
      g.test_framework  nil
      g.assets  false
      g.helper  false
      g.jbuilder  false
    end
  end
end
