class Forms
  def self.bp_controller(&block)
    form = Formotion::Form.new({
      sections: [{
          title: 'Blood Pressure',
          rows: [{
            title: 'Diastolic',
            key: :diastolic,
            placeholder: '120',
            type: :number
          }, {
            title: 'Systolic',
            key: :systolic,
            placeholder: '80',
            type: :number
          }, {
            title: 'Heart Rate',
            key: :rate,
            placeholder: '80',
            type: :number
          }]
      }, {
        rows: [{
            title: "Add",
            type: :submit,
        }]
      }]
    })

    form.on_submit do |response_form|
      answers = response_form.render

      bp = [answers[:diastolic], answers[:systolic]]
      rate = answers[:rate]

      events = App::Persistence['events'] || []
      event_id = App::Persistence['event_id'].to_i + 1

      event = { diastolic: bp.first, systolic: bp.last, rate: rate, at: Time.now, id: event_id }
      events = events + [event]
      App::Persistence['events'] = events
      App::Persistence['event_id'] = event_id

      block.call event
    end

    Formotion::FormController.alloc.initWithForm form
  end
end
