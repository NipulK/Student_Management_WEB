require 'mongo'
Mongo::Logger.logger.level = ::Logger::FATAL

client = Mongo::Client.new(['127.0.0.1:27017'], database: 'student_db')
COL = client[:students]

class Student
  def self.all
    COL.find.to_a
  end

  def self.create(name, age)
    COL.insert_one({ name: name, age: age })
  end

  def self.find(id)
    COL.find(_id: BSON::ObjectId(id)).first
  end

  def self.update(id, name, age)
    COL.find(_id: BSON::ObjectId(id))
       .update_one({ '$set' => { name: name, age: age } })
  end

  def self.delete(id)
    COL.find(_id: BSON::ObjectId(id)).delete_one
  end
end
