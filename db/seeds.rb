User.create(email: 'admin@admin.com', age: 50, gender: :female, password: '123123', admin: true)
5.times do |i|
  User.create(email: "rspecer#{i}@rspec.com", age: rand(100), gender: rand(2), password: '123123')
end

15.times do |i|
  Interest.create(name: "doing #{i} things at once")
end

User.all.each do |user|
  user.interests << Interest.all.sample(rand(2..5))
end
