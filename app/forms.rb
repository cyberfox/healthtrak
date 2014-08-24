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

      bp = BloodPressure.from_answers(answers)

      block.call bp
    end

    Formotion::FormController.alloc.initWithForm form
  end
end
