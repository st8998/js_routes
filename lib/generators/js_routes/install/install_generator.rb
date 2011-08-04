require 'rails'

module JsRoutes
  module Generators
    class InstallGenerator < ::Rails::Generators::Base

      desc "This generator install JsRoutes pathBuilder.js which contains utils for building routes on client side"
      source_root File.expand_path('../../../../assets/javascripts', __FILE__)

      def copy_pathbuilder
        say_status("copying", "jquery.pathBuilder.js (#{JsRoutes::VERSION})", :green)

        copy_file "jquery.pathBuilder.js", "public/javascripts/jquery.pathBuilder.js"
      end
    end
  end
end