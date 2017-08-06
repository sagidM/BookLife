def configure
  Faker::Config.random = Random.new 42
  Faker::Config.locale = :ru
end
IMAGE_FORMATS = %w(png jpg bmp)
def random_avatar(width=0, height=0)
  width = rand 100..400 if width == 0
  height = rand 200..600 if height == 0
  Faker::Avatar.image(nil,
                      "#{width}x#{height}",
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

    desc 'Create abstract books and their authors'
    task :abstract_books, [:count] => :environment do |_, args|
      count = extract_count args
      populate_abstract_books_and_authors count
    end

    desc 'Create books for each abstract book and their houses'
    task :books, [:count] => :environment do |_, args|
      count = extract_count args
      populate_books_and_houses count/3
    end
  end

  desc 'Create records in database'
  task :populate, [:count] => :environment do |_, args|
    count = extract_count args
    populate_users count
    populate_abstract_books_and_authors count
    populate_books_and_houses count/3

    if User.find_by_email('q@q.q').nil?
      User.create! first_name: 'q', email: 'q@q.q', password: '123qwe'
    end
    series = BookSeries.new name: Faker::Book.title, poster: random_avatar(300, 400)
    series.abstract_books = AbstractBook.limit(count/2)
    series.save
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
      patronymic: Faker::Name.first_name,
      avatar: random_avatar,
      bdate: Faker::Date.birthday,
  }
end

def populate_authors(count)
  configure
  count.times {Author.create! random_author_hash}
  puts "#{count} authors created"
end

def populate_abstract_books_and_authors(count)
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
  puts "#{count} abstract books and #{authors.count{|a| not a.new_record?}} authors were created"
end

def populate_books_and_houses(houses_count)
  configure
  houses = (0...houses_count).to_a.map do
    PublishingHouse.new({
      name: Faker::Book.publisher,
      description: Faker::Company.bs,
      logo: Faker::Company.logo,
      year_of_foundation: Faker::Date.birthday
    })
  end
  types = ['Ebook', 'Audiobook']
  AbstractBook.all.each do |ab|
    Book.create!({
        type: types[Faker::Config.random.rand(0...types.size)],
        abstract_book: ab,
        name: ab.original_name,
        published_at: ab.published_at,
        language: 'en',
        poster: random_avatar(),
        background_image: nil,
        description: Faker::Lorem.paragraph,
        publishing_house: houses.sample,
     })
  end
  puts "#{AbstractBook.count} books and #{houses.count{|h| not h.new_record?}} houses were created"
end




# big data
=begin
raise 'generating large sql; comment lines below!'

def generate_author_sql_values
  n = Faker::Name
  insert = 'insert into authors(first_name, surname, patronymic, bdate, created_at, updated_at) values '
  values = "('#{n.first_name.gsub("'", "''")}', '#{n.last_name.gsub("'", "''")}', '#{n.first_name.gsub("'", "''")}', '#{Faker::Date.birthday}', '#{Time.now}', '#{Time.now}');\n"
  insert + values
end

sql = (0..10000).to_a.map { generate_author_sql_values }.join; nil
f = File.expand_path('~/1/data.sql')
File.write(f, sql)
=end
