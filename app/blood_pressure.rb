class BloodPressure < CDQManagedObject
  def self.from_answers(answers)
    create(diastolic: answers[:diastolic].to_i,
           systolic: answers[:systolic].to_i,
           rate: answers[:rate].to_i).tap { cdq.save }
  end
end
