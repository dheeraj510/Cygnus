# By using the symbol ':user', we get Factory Girl to simulate the User model.
Factory.define :user do |user|
  user.email                 "testuser0@example.com"
  user.password              "testuser0"
  user.password_confirmation "testuser0"
end
