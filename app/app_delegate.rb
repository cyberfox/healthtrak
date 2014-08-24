class AppDelegate < PM::Delegate
  include CDQ
  status_bar true, animation: :none

  def on_load(app, options)
    return true if RUBYMOTION_ENV == "test"
    cdq.setup
    open_tab_bar HomeScreen.new(nav_bar: true), Event2Screen.new(nav_bar: true), HelpScreen.new(nav_bar: true)
    true
  end
end
