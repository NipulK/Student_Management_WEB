require 'mongo'
Mongo::Logger.logger.level = ::Logger::FATAL

client = Mongo::Client.new(['127.0.0.1:27017'], database: 'student_web')
USERS = client[:users]

class User
  def self.create(username, password)
    USERS.insert_one({ username: username, password: password })
  end

  def self.authenticate(username, password)
    USERS.find({ username: username, password: password }).first
  end
end
