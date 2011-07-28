module JsRoutes

  class Railtie < ::Rails::Railtie

    config.before_configuration do
      config.action_view.javascript_expansions[:defaults] |= %w{ js_routes jquery.pathBuilder.js }
    end

    config.after_initialize do
      if Rails.env.development?
        ApplicationController.class_eval do
          before_filter do
            JsRoutes.generate_routes_file
          end
        end
      end
    end

    initializer 'js_routes.generate_routes_file', :after=> :build_middleware_stack do |app|
      JsRoutes.generate_routes_file
      FileUtils.cp File.expand_path('../../assets/javascripts/jquery.pathBuilder.js', __FILE__), File.join(Rails.root, 'public', 'javascripts')
    end

  end

  def self.generate_routes_file
    puts 'GENERATING ROUTES FILE'
    filename = File.join(Rails.root, 'public', 'javascripts', 'js_routes.js')
    FileUtils.rm filename, :force => true
    File.open(filename, 'w') do |f|
      f << 'window.Routes = {};'
      Rails.application.routes.routes.each do |route|
        defaults = route.defaults

        continue if defaults.present? && defaults.has?(:exclude_from_js)

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