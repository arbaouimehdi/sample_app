User.create!(
    name:                  'Example User',
    email:                 'example@railstuorial.org',
    password:              'foobar',
    password_confirmation: 'foobar',
    admin:                  true,
    activated:              true,
    activated_at:           Time.zone.now
)

# Create 99 users
99.times do |n|
  name     = Faker::Name::name
  email    = Faker::Internet::email
  password = 'foobar'
  User.create!(
      name:                  name,
      email:                 email,
      password:              password,
      password_confirmation: password,
      admin:                 false,
      activated:             true,
      activated_at:          Time.zone.now
  )

end