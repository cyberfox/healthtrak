class Event2Screen < PM::TableScreen
  title 'Health Log'

  def table_data
    pressures = BloodPressure.sort_by(:created_at, order: :descending).limit(10).to_a

    [{cells:
          pressures.map do |bp|
            { title: colored_bp(bp), subtitle: to_date_string(bp.created_at) }
          end
     }]
  end

  def colored_bp(event)
    color = if event.diastolic < 130 && event.systolic < 80
              UIColor.greenColor
            elsif event.diastolic > 140 || event.systolic > 90
              UIColor.redColor
            else
              UIColor.yellowColor
            end
    format_bp(event).attrd.foreground_color(color)
  end

  def format_bp(event)
    "#{event.diastolic}/#{event.systolic}".tap do |base|
      base << " @ #{event.rate}bpm" if event.rate
    end
  end

  def on_load
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
      update_table_data
    end

    self.navigationController.pushViewController(bp_form, animated: true)
  end

  DATE_FORMATTER = NSDateFormatter.alloc.init.tap {|df| df.dateFormat = 'yyyy-MM-dd'}

  def to_date_string(time)
    DATE_FORMATTER.stringFromDate(time)
  end

  TIME_FORMATTER = NSDateFormatter.alloc.init.tap {|df| df.dateFormat = "HH:mm:ss Z"}

  def to_time_string(time)
    time ? TIME_FORMATTER.stringFromDate(time) : 'unknown'
  end
end
