# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create!(
  first_name: '直人',
  last_name: '助名',
  first_name_kana: 'ナオト',
  last_name_kana: 'スケナ',
  date_of_birth: '1995-09-27',
  phone_number: '00011112222',
  login_id: 'admin123',
  email: 'admin@sample.com',
  password: '123456',
  )
  
