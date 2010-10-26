module Jquery
  class InstallGenerator < Rails::Generators::Base
    PATH = source_root File.expand_path('../templates', __FILE__)
    # Options
    class_option :ui, :type => :boolean, :defalut => false, :desc => "Add jquery-ui components to application."
    class_option :ui_version, :type => :string, :defalut => "1.8.5", :desc => "Version of jquery-ui components to application."
    class_option :version, :type => :string, :defalut => "1.4.3", :desc => "Version of jquery used in application."
  
    
    JS_DEST = "public/javascripts"
    CSS_DEST = "public/stylesheets"
    
    def remove_prototype
      old_scritps = %w(controls dragdrop effects prototype)
      old_scripts.each do |script|
        path = "#{JS_DEST}/#{script}.js"
        remove_file path if File.exist? path 
      end
    end
  
    def install_jquery
      @javascripts = []
      @stylesheets = []
  
      get "http://ajax.googleapis.com/ajax/libs/jquery/#{options.version}/jquery.min.js", "#{JS_DEST}/jquery.js"
      @javascripts <<  "jquery"
      get "http://github.com/rails/jquery-ujs/raw/master/src/rails.js", "#{JS_DEST}/rails.js"
      @javascripts <<  "rails"
      if options.ui?      
        get "http://ajax.googleapis.com/ajax/libs/jqueryui/#{options.ui_version}/jquery-ui.min.js", "#{JS_DEST}/jquery-ui.js"  
      end
      
    end
  
    private
  
    def jquery_version
      version = JQUERY_VERSION
      version = version + ".min" if options.min?
      return version
    end
  
    
  
  end
end