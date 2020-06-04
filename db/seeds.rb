# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(
  username: 'adc',
  email: 'adc@mail.com',
  display_name: 'ADC',
  admin: true,
  password: 'qwerty',
)

Tweet.create!(
  body: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. At quanta conantur! Mundum hunc omnem oppidum esse nostrum! Incendi igitur eos, qui audiunt, vides.',
  user_id: 1,
)
