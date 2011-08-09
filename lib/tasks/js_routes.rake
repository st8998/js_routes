desc "Generate js routes"
task :js_routes => :environment do
  JsRoutes.generate_routes_file
end
