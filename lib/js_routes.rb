module JsRoutes
  if ::Rails.version < "3.1"
    require 'js_routes/railtie'
  else
    require 'js_routes/engine'
  end
  require 'js_routes/version'
end
