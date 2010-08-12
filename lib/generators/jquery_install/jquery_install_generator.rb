class JqueryInstallGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)
  # Options
  class_option :ui, :type => :boolean, :defalut => true, :desc => "add jquery-ui components to application"
  class_option :min, :type => :boolean, :default => false, :desc => "Use min versions of jquery and ui components"

  JQUERY_VERSION = "1.4.2"
  JS_DEST = "public/javascripts"

  def install_jquery
    copy_file "jquery-#{jquery_version}.js", "#{JS_DEST}/jquery-#{jquery_version}.js"
    copy_file "rails.js", "#{JS_DEST}/rails.js"

  end

  private
  def jquery_version
    version = JQUERY_VERSION
    version = version + ".min" if options.min?
    return version
  end
end
