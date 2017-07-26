FactoryGirl.define do
  factory :user do
    email       'factory@example.com'
    password    '123qwe'
    first_name  'Ivan'
    surname     'Nikolaev'
    bdate       '2000-04-01'
  end
end
