class EventController < UIViewController
  attr_accessor :tab_controller
  attr_accessor :nav_controller

  def viewDidLoad
    super
    self.title = 'Health Log'
    @myButton = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemAdd,
                                                                  target: self,
                                                                  action: :do_add_log_entry)
    self.navigationItem.rightBarButtonItem = @myButton
  end

  def do_add_log_entry
    self.performSelectorOnMainThread :addLogEntry, withObject: nil, waitUntilDone: false
  end

  def addLogEntry
    bp_form = Forms.bp_controller do |event|
      puts event.inspect
      self.navigationController.popViewControllerAnimated(true)
    end

    self.navigationController.pushViewController(bp_form, animated: true)
  end

  def viewWillAppear(animated)
    @table = UITableView.alloc.initWithFrame(self.view.bounds)
    self.view.addSubview @table
    @table.dataSource = self
    @table.delegate = self
  end

  DATE_FORMATTER = NSDateFormatter.alloc.init.tap {|df| df.dateFormat = 'yyyy-MM-dd'}

  def to_date_string(time)
    DATE_FORMATTER.stringFromDate(time)
  end

  def generate_events
    all_events = App::Persistence['events'] || []
    date_set = {}
    date_list = []
    all_events.each do |event|
      at = event['at']
      date = at ? to_date_string(at) : 'unknown'
      unless date_set[date]
        date_set[date] = []
        date_list << date
      end
      date_set[date] << event
    end
    [date_set, date_list]
  end

  def numberOfSectionsInTableView(tableView)
    answer_set, answer_list = generate_events
    answer_list.length
  end

  def tableView(tableView, titleForHeaderInSection: section)
    answer_set, answer_list = generate_events
    answer_list[section]
  end

  TIME_FORMATTER = NSDateFormatter.alloc.init.tap {|df| df.dateFormat = "HH:mm:ss Z"}

  def to_time_string(time)
    time ? TIME_FORMATTER.stringFromDate(time) : 'unknown'
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= "CELL_IDENTIFIER"

    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier) || begin
      UITableViewCell.alloc.initWithStyle(UITableViewCellStyleSubtitle, reuseIdentifier:@reuseIdentifier)
    end

    answer_set, answer_list = generate_events
    event = answer_set[answer_list[indexPath.section]][indexPath.row]

    cell.textLabel.text = "#{event['diastolic']}/#{event['systolic']} @ #{event['rate']}bpm"
    cell.detailTextLabel.text = to_time_string(event['at'])

#    if entry['image']
#      cell.imageView.image = entry['image']
#    else
#      cell.imageView.image = UIImage.imageNamed "01-refresh"
#      start_refresh(entry)
#    end

    cell
  end

  def tableView(tableView, numberOfRowsInSection: section)
    answer_set, answer_list = generate_events
    answer_set[answer_list[section]].length
  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  end
end
