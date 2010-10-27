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
      old_scripts = %w(controls dragdrop effects prototype)
      old_scripts.each do |script|
        path = "#{JS_DEST}/#{script}.js"
        remove_file path if File.exist? path 
      end
    end
  
    def install_jquery
      version = (options[:version].nil?)? "1.4.3" :  options[:version]
      ui_version = (options[:ui_version].nil?)? "1.8.5" :  options[:ui_version]
      url = "http://ajax.googleapis.com/ajax/libs/jquery/#{version}/jquery.min.js"
      #puts url
      get url, "#{JS_DEST}/jquery.js"
      
      get "http://github.com/rails/jquery-ujs/raw/master/src/rails.js", "#{JS_DEST}/rails.js"
      url = "http://ajax.googleapis.com/ajax/libs/jqueryui/#{ui_version}/jquery-ui.min.js"
      #puts url
      if options.ui?      
        get url, "#{JS_DEST}/jquery-ui.js"  
      end
      
    end
  
    
  
  end
end