desc "Generate js routes"
task :js_routes do
  JsRoutes.generate_routes_file
end
