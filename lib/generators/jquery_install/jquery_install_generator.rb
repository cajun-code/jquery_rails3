class JqueryInstallGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)
  # Options
  class_option :ui, :type => :boolean, :defalut => false, :desc => "Add jquery-ui components to application."
  class_option :effect, :type => :boolean, :default =>false, :desc =>"Add jquery-ui effect commponents to application"
  class_option :min, :type => :boolean, :default => false, :desc => "Use min versions of jquery and ui components."
  class_option :components, :type => :array, :default => [], :desc => "List the Jquery-ui Components to include. Leaving blank will include all components."
  class_option :effects, :type => :array, :default =>[], :desc => "List of the Jquery-ui Effects to include. Leaving blank will include all effects."
  class_option :theme, :type=>:string, :default => "base", :desc => "Name of the theme to apply to the components. Options are \"base\" or \"smoothness\"."

  JQUERY_VERSION = "1.4.2"
  JS_DEST = "public/javascripts"
  CSS_DEST = "public/stylesheets"
  EFFECTS =%w(blind bounce clip core drop explode fold highlight pulsate scale shake slide transfer)
  COMPONENTS=%w(core accordion autocomplete button datepicker dialog draggable droppable mouse position progressbar resizable selectable slider sortable tabs widget custom)


  def install_jquery
    @javascripts = []
    @stylesheets = []

    copy_file "jquery-#{jquery_version}.js", "#{JS_DEST}/jquery-#{jquery_version}.js"
    @javascripts <<  "\"jquery-#{jquery_version}\""
    copy_file "rails.js", "#{JS_DEST}/rails.js"
    @javascripts <<  "\"rails\""
    if options.ui?      
      copy_components
      stylesheet
    end
    if options.effect?
      copy_effects
    end
    #insted of rewriteing layout
    # JavaScript files you want as :defaults (application.js is always included).
    # config.action_view.javascript_expansions[:defaults] = %w(jquery rails)
    template "layout.html.erb", "app/views/layouts/application.html.erb"
  end

  private

  def jquery_version
    version = JQUERY_VERSION
    version = version + ".min" if options.min?
    return version
  end

  def javascripts
    @javascripts.join(", ")
  end

  def stylesheets
    @stylesheets.join(", ")
  end

  def copy_effects
    effects = []
    if options.effects.empty?
      effects = EFFECTS
    else
      effects = options.effects
    end
    unless effects.include? "core"
      effects << "core"
    end
    effects.each { |effect| copy_component("effect",effect)if EFFECTS.include?(effect) }
  end


  def copy_components
    components = []
    if options.components.empty?
      components = COMPONENTS
    else
      components = options.components
    end
    unless components.include? "core"
      components << "core"
    end
    components.each { |component| copy_component("ui",component) if COMPONENTS.include?(component)}

  end
  # Copy one of the components to
  def copy_component(state, name)
    name = "jquery.#{state}.#{name.downcase}"
    name = name + ".min" if options.min?
    @javascripts << "\"#{name}\""
    folder=""
    if options.min?
      folder = "ui-min"
    else
      folder = "ui"
    end
    copy_file "#{folder}/#{name}.js", "#{JS_DEST}/#{name}.js"
  end

  def stylesheet
    name = "jquery.ui.all"
    @stylesheets << name
    copy_file "themes/#{options.theme}/#{name}.css", "#{CSS_DEST}/#{name}.css"
  end

end
