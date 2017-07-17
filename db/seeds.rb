User.create(email: 'admin@admin.com', age: 50, gender: :female, password: '123123', admin: true)

5.times do |i|
  user = User.create(email: "rspecer#{i}@rspec.com", age: rand(100), gender: rand(2), password: '123123')
  rand(1..4).times do |j|
    user.interests.create(name: "doing #{i}#{j} things at once", interest_type: rand(3))
  end
end

# users to be queried for 6th requirement
10.times do |i|
  User.create(email: "somewoman#{i}@rspec.com", age: rand(20..30), gender: 'female', password: 'pinkcats')
end

Interest.create(name: 'cosmetic stuff', interest_type: 'health', user: User.all.sample)
Interest.create(name: 'cosmos science', interest_type: 'health', user: User.all.sample)
Interest.create(name: 'cosmic whatever', interest_type: 'health', user: User.all.sample)
Interest.create(name: 'cosmeticizing', interest_type: 'health', user: User.all.sample)
Interest.create(name: 'cosmetologist', interest_type: 'health', user: User.all.sample)
Interest.create(name: 'comics', interest_type: 'hobby', user: User.all.sample)
Interest.create(name: 'cosmochemistry', interest_type: 'work', user: User.all.sample)
Interest.create(name: 'cosmography', interest_type: 'work', user: User.all.sample)
Interest.create(name: 'cosmedy', interest_type: 'hobby', user: User.all.sample)
Interest.create(name: 'cosmograpical', interest_type: 'hobby', user: User.all.sample)

# there is some chance, that none of created records will match the query
# in that case at least those should be ok:

age_edge_case1 = User.create(email: 'edge1@rspec.com', age: 30, gender: 'female', password: '123123')
age_edge_case2 = User.create(email: 'edge2@rspec.com', age: 20, gender: 'female', password: '123123')
young_woman = User.create(email: 'somebody@rspec.com', age: 25, gender: 'female', password: '123123')
Interest.create(name: 'cosmetics collector', interest_type: 'health', user: young_woman)
Interest.create(name: 'cosmetics collector', interest_type: 'health', user: age_edge_case1)
Interest.create(name: 'cosmetics collector', interest_type: 'health', user: age_edge_case2)
