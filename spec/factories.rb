# By using the symbol ':user', we get Factory Girl to simulate the User model.
Factory.define :user do |user|
  user.email                            "testuser0@example.com"
  user.password                      "testuser0"
  user.password_confirmation "testuser0"
  user.website_id                     1
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end

Factory.define :website do |website|
  website.name  "Factory Website"
  website.title     "A factory website"
end
