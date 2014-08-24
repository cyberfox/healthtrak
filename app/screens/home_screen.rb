SHADOW_COLOR = UIColor.colorWithRed(40.0/255.0, green: 40.0/255.0, blue:40.0/255.0, alpha:0.4)

class CenteredLabel < UILabel
  def title=(x)
    self.text = x.upcase
    unless @look_configured
      self.textAlignment = UITextAlignmentCenter
      self.textColor = UIColor.darkGrayColor

      self.shadowOffset = [1.0, 1.0]
      self.shadowColor = SHADOW_COLOR
      @look_configured = true
    end
  end
end

class CenteredCell < UITableViewCell
  attr_accessor :cell

  def initialize
    @reuseIdentifier ||= "HDR_IDENTIFIER"
    self.cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleSubtitle, reuseIdentifier:@reuseIdentifier)
    cell.textLabel.textAlignment = UITextAlignmentCenter
  end
end

class HomeScreen < PM::GroupedTableScreen
  title "Menu"

  def on_load
    set_nav_bar_button :right, title: "Help", action: :show_help
  end

  def viewDidAppear(animated)
    super
    puts promotion_table_data.section(0).inspect
  end

  def show_help
    open HelpScreen
  end

  def table_data
    [
        {
            title: "Measurements",
            title_view: CenteredLabel,
            cells: [
                {title: "Blood Pressure", action: :show_bp_screen},
                {title: "Blood Glucose", action: :show_glucose_screen},
                {title: "Weight", action: :show_weight_screen}
            ]
        }
    ]
  end

  def show_bp_screen
    open Event2Screen
  end

  # def show_glucose_screen
  # end
  #
  # def show_weight_screen
  # end
end
