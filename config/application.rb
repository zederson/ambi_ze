require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

def log_info(message)
  Rails.logger.info message
  true
end

def log_error(message)
  Rails.logger.error message
  true
end

module AmbiZe
  extend self
  attr_accessor :settings

  self.settings    = YAML.load_file('config/app_config.yml')

  class Application < Rails::Application

     config.autoload_paths              += %W(#{config.root}/lib)
     config.encoding                     = "utf-8"
     config.i18n.default_locale          = :pt
     config.time_zone                    = 'Brasilia'
     config.cache_classes                = true
     config.middleware.delete Rack::Lock
     config.assets.enabled               = true
     config.assets.paths << Rails.root.join("app", "assets", "fonts")
     config.assets.precompile << /\.(?:svg|eot|woff|ttf)$/
  end
end
