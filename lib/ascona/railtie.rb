# frozen_string_literal: true

module Ascona
  class Railtie < Rails::Railtie
    initializer "ascona.load_icons" do
      Ascona.load
    end

    initializer "ascona.helper" do
      ActiveSupport.on_load(:action_view) do
        include Ascona::Helper
      end
    end
  end
end
