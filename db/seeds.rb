# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Resident.create!(
  first_name: '太郎',
  last_name: '田中',
  first_name_kana: 'タロウ',
  last_name_kana: 'タナカ',
  date_of_birth: '1950-11-27',
  phone_number: '00022223333',
  login_id: 'sample1',
  password: '123456',
  )