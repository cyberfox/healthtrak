schema "0001 initial" do
  entity "BloodPressure" do
    integer16 :diastolic, optional: false
    integer16 :systolic, optional: false
    integer16 :rate, optional: true

    string :note
    datetime :created_at
    datetime :updated_at
  end

  entity "BloodGlucose" do
    integer16 :glucose, optional: false

    string :note
    datetime :created_at
    datetime :updated_at
  end

  entity "Weight" do
    integer16 :weight, optional: false

    string :note
    datetime :created_at
    datetime :updated_at
  end

  entity "FoodPicture" do
    integer16 :calories
    binary :picture

    string :note
    datetime :created_at
    datetime :updated_at
  end

  # Examples:
  #
  # entity "Person" do
  #   string :name, optional: false
  #
  #   has_many :posts
  # end
  #
  # entity "Post" do
  #   string :title, optional: false
  #   string :body
  #
  #   datetime :created_at
  #   datetime :updated_at
  #
  #   has_many :replies, inverse: "Post.parent"
  #   belongs_to :parent, inverse: "Post.replies"
  #
  #   belongs_to :person
  # end
end
