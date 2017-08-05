def configure
  Faker::Config.random = Random.new 42
  Faker::Config.locale = :ru
end
IMAGE_FORMATS = %w(png jpg bmp)
def random_avatar
  Faker::Avatar.image(nil,
                      "#{rand 100..400}x#{rand 200..600}",
                      IMAGE_FORMATS.sample,
                      "set#{rand 1..4}",
                      "bg#{rand 1..2}")
end
def extract_count(args)
  (args[:count] || 60).to_i
end


namespace :db do
  namespace :populate do
    desc 'Create only users'
    task :users, [:count] => :environment do |_, args|
      count = extract_count args
      populate_users count
    end

    desc 'Create only authors'
    task :authors, [:count] => :environment do |_, args|
      count = extract_count args
      populate_authors count
    end

    desc 'Create books and their authors'
    task :books, [:count] => :environment do |_, args|
      count = extract_count args
      populate_books_and_authors count
    end
  end
  desc 'Create records in database'
  task :populate, [:count] => :environment do |_, args|
    count = extract_count args
    populate_users count
    populate_books_and_authors count
  end
end


def populate_users(count)
  configure

  count.times do
    params = {
        first_name: Faker::Name.first_name,
        surname: Faker::Name.last_name,
        avatar: random_avatar,
        bdate: Faker::Date.birthday,
        email: Faker::Internet.email,
        password: '123qwe'
    }

    User.create! params
  end
  puts "#{count} users created"
end

def random_author_hash
  {
      first_name: Faker::Name.first_name,
      surname: Faker::Name.last_name,
      patronymic: Faker::Name.parent_name,
      avatar: random_avatar,
      bdate: Faker::Date.birthday,
  }
end

def populate_authors(count)
  configure
  count.times {Author.create! random_author_hash}
  puts "#{count} authors created"
end

def populate_books_and_authors(count)
  configure

  authors = (0..count/3).to_a.map {Author.new random_author_hash}
  authors[0].user_id = 1

  from, to = Date.new(1950), Date.today
  count.times do |i|
    params = {
        abstract_book: AbstractBook.new(original_name: Faker::Book.title,
                                        published_at: Faker::Date.between(from, to)),
        author: authors.sample,
        position: i
    }

    AbstractBookAuthor.create! params
  end
  puts "#{count} books and #{authors.count{|a| not a.new_record?}} authors created"
end
