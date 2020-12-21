# Create a default company
company = Company.create!(name: 'Phoenixfire Development', active: true)
company_2 = Company.create!(name: 'Blackwing Development', active: false)

# Create the seed user
User.create!(first_name: ENV.fetch('SEED_USER_FIRST_NAME', nil),
             last_name: ENV.fetch('SEED_USER_LAST_NAME', nil),
             email: ENV.fetch('SEED_USER_EMAIL', nil),
             password: ENV.fetch('SEED_USER_PASSWORD', nil),
             password_confirmation: ENV.fetch('SEED_USER_PASSWORD_CONFIRMATION', nil),
             company: company)

# https://randomuser.me/api/?results=49&password=upper,lower,32&nat=us
user_data = JSON.parse(File.open('/app/src/db/seed_users.json').read)
company_ids = Company.all.pluck(:id)
user_data['results'].each do |result|
  User.create!(first_name: result['name']['first'],
               last_name: result['name']['last'],
               email: result['email'],
               password: result['login']['password'],
               password_confirmation: result['login']['password'],
               company_id: company_ids.sample)
end

lead_data = JSON.parse(File.open('/app/src/db/seed_leads.json').read)

company_hash = {}

# Keys are the company ids and values are the users_ids
# { 1 => [1,2,3], 2 => [4,5,6] }
company_ids.each { |k| company_hash[k] = User.where(company_id: k).pluck(:id) }

lead_data['results'].each do |result|
  company_id = company_hash.keys.sample
  Lead.create!(name: [result['name']['first'], result['name']['last']].join(' '),
               company_id: company_id,
               assignable_id: company_hash[company_id].sample)
end
