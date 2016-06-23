FactoryGirl.define do
  factory :itienary do
    title               'Go to Airport'
    content             'we need commitment time to be in airport right away on time.'
    transportation      'car'
    location            'Cengkareng , Tangerang'
    lat                 -6119097
    lng                 106674312
    start_date          DateTime.now - 2.month
  end
end
