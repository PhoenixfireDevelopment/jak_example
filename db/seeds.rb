# Create a default company
company = Company.create!(name: 'Phoenixfire Development', active: true)

# Create the seed user
User.create!(first_name: ENV.fetch('SEED_USER_FIRST_NAME', nil),
             last_name: ENV.fetch('SEED_USER_LAST_NAME', nil),
             email: ENV.fetch('SEED_USER_EMAIL', nil),
             password: ENV.fetch('SEED_USER_PASSWORD', nil),
             password_confirmation: ENV.fetch('SEED_USER_PASSWORD_CONFIRMATION', nil),
             company: company)
