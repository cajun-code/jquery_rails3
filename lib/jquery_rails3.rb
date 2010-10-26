module Jquery  
    class Railtie < Rails::Railtie
      config.before_initialize do
        if Rails.root.join("public/javascripts/jquery-ui.js").exist?
          config.action_view.javascript_expansions[:defaults] = %w(jquery jquery-ui rails)
        else
          config.action_view.javascript_expansions[:defaults] = %w(jquery rails)
        end
      end
    end  
end
