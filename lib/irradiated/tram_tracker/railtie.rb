module Irradiated
  module TramTracker
    class Railtie < ::Rails::Engine
      initializer "Irradiated::TramTracker.assets.precompile" do |app|
        app.config.assets.precompile += %w( TramTracker.css, TramTracker.js )
      end
    end
  end
end
