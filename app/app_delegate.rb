class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)

#    @form_controller = Forms.bp_controller
#    @form_controller.title = 'Settings'
#    @form_controller.tabBarItem = UITabBarItem.alloc.initWithTitle('BP Entry', image: UIImage.imageNamed('19-gear'), tag: 2)

    @event_controller = EventController.alloc.initWithNibName(nil, bundle:nil)
    @navigation_controller = UINavigationController.alloc.initWithRootViewController(@event_controller)
    @navigation_controller.title = 'Health Log'
    @navigation_controller.tabBarItem = UITabBarItem.alloc.initWithTitle('Health Log', image: UIImage.imageNamed('79-medical-bag'), tag: 1)

    @pill_controller = UIViewController.new
    @pill_nav = UINavigationController.alloc.initWithRootViewController(@pill_controller)
    @pill_nav.title = 'Medicine'
    @pill_nav.tabBarItem = UITabBarItem.alloc.initWithTitle('Medicine', image: UIImage.imageNamed('94-pill'), tag: 2)

    @food_controller = UIViewController.new
    @food_nav = UINavigationController.alloc.initWithRootViewController(@food_controller)
    @food_nav.title = 'Food'
    @food_nav.tabBarItem = UITabBarItem.alloc.initWithTitle('Food', image: UIImage.imageNamed('125-food'), tag: 3)

    controllers = [@navigation_controller, @pill_nav, @food_nav]
    @tab_controller = UITabBarController.alloc.initWithNibName(nil, bundle: nil)
    @event_controller.tab_controller = @tab_controller
    @event_controller.nav_controller = @navigation_controller
    @tab_controller.viewControllers = controllers
    @tab_controller.selectedViewController = @navigation_controller
    @window.rootViewController = @tab_controller
    @window.makeKeyAndVisible
    true
  end
end
