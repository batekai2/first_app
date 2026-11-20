email = ENV.fetch("BOOTSTRAP_USER_EMAIL", "admin@example.com")
password = ENV.fetch("BOOTSTRAP_USER_PASSWORD") do
  raise "BOOTSTRAP_USER_PASSWORD を設定してから db:seed を実行してください。" if Rails.env.production?

  "ChangeMeNow!123"
end

user = User.find_or_initialize_by(email: email)
user.password = password
user.save!

puts "Seeded user: #{user.email}"
