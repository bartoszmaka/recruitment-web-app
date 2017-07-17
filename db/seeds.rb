User.create(email: 'admin@admin.com', age: 50, gender: :female, password: '123123', admin: true)
5.times do |i|
  user = User.create(email: "rspecer#{i}@rspec.com", age: rand(100), gender: rand(2), password: '123123')
  rand(1..4).times do |j|
    user.interests.create(name: "doing #{i}#{j} things at once")
  end
end
