def configure
  Faker::Config.random = Random.new 42
  Faker::Config.locale = :ru
end


namespace :db do
  namespace :populate do
    desc 'Create records in database'
    task :users, [:count] => :environment do |t, args|
      configure

      count = (args[:count] || 10).to_i
      formats = ['png', 'jpg', 'bmp']
      count.times do
        rand_avatar = Faker::Avatar.image(nil,
                                     "#{rand 100..400}x#{rand 200..600}",
                                     formats.sample,
                                     "set#{rand 1..4}",
                                     "bg#{rand 1..2}")

        params = {
          first_name: Faker::Name.first_name,
          surname: Faker::Name.last_name,
          avatar: rand_avatar,
          bdate: Faker::Date.birthday,
          email: Faker::Internet.email,
          password: '123qwe'
        }

        User.create! params
      end
      puts "#{count} users created"
    end
  end
end
