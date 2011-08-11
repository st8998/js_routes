module JsRoutes

  class Middleware
    def initialize app
      @app = app
    end

    def call(env)
      JsRoutes.generate_routes_file

      @app.call(env)
    end
  end

  class Railtie < ::Rails::Railtie

    initializer "js_routes.insert_middleware" do |app|
      if Rails.env.development?
        app.config.middleware.insert_after ActionDispatch::Head, JsRoutes::Middleware
      end
    end

    rake_tasks do
      Dir[File.join(File.dirname(__FILE__), '../tasks/*.rake')].each { |f| load f }
    end

    config.before_configuration do
      config.action_view.javascript_expansions[:defaults] |= %w{ js_routes jquery.pathBuilder.js }
    end

  end

  def self.generate_routes_file
    puts 'GENERATING ROUTES FILE'
    filename = File.join(Rails.root, 'public', 'javascripts', 'js_routes.js')
    FileUtils.rm filename, :force => true
    File.open(filename, 'w') do |f|
      f << 'window.Routes = {};'
      Rails.application.reload_routes!
      Rails.application.routes.routes.each do |route|
        defaults = route.defaults

        unless defaults.present? && defaults.has_key?(:exclude_from_js) && defaults[:exclude_from_js]
          f << <<-JS.strip
            Routes.#{route.name}_path = function() {
                Array.prototype.unshift.call(arguments, '#{route.path}');
                return $.buildPath.apply($, arguments);
            };
          JS
        end
      end
    end
  end

end
