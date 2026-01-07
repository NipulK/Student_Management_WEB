require 'bundler/setup'
require './models/user'

User.create("admin", "1234")
puts "Admin user created successfully!"
