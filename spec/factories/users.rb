FactoryBot.define do
  factory :user do
    first_name { 'Test' }
    last_name { 'McTesterson' }
    password { 'password' }
    sequence :email do |n|
      "#{n}email@email.com"
    end

  end
end
