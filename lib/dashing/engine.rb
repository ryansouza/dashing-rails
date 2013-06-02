module Dashing
  class Engine < ::Rails::Engine
    config.assets.paths << Dashing.app_dashing_path
    config.assets.precompile += ["dashing.js", "dashing.css", "dashing-widgets.css", "dashing-widgets.js"]

    initializer "add dashboard jobs to path" do
      Dir["#{Rails.root}/#{Dashing.app_dashing_path}/jobs/*.rb"].each do |file|
        require file
      end
    end
  end
end
