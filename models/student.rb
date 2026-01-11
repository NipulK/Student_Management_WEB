require 'mongo'
Mongo::Logger.logger.level = ::Logger::FATAL

client = Mongo::Client.new(['127.0.0.1:27017'], database: 'student_web')
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
require 'mongo'
Mongo::Logger.logger.level = ::Logger::FATAL

client = Mongo::Client.new(['127.0.0.1:27017'], database: 'student_web')
COL = client[:students]

class Student

  def self.all
    COL.find.to_a
  end

  def self.create(data)
    COL.insert_one({
      name: data[:name],
      age: data[:age],
      address: data[:address],
      mobile: data[:mobile],
      nic: data[:nic],
      school: data[:school]
    })
  end

  def self.find(id)
    COL.find(_id: BSON::ObjectId(id)).first
  end

  def self.update(id, data)
    COL.find(_id: BSON::ObjectId(id)).update_one(
      '$set' => {
        name: data[:name],
        age: data[:age],
        address: data[:address],
        mobile: data[:mobile],
        nic: data[:nic],
        school: data[:school]
      }
    )
  end

  def self.delete(id)
    COL.find(_id: BSON::ObjectId(id)).delete_one
  end

  def self.search(keyword)
    COL.find({
      '$or' => [
        { name: /#{keyword}/i },
        { mobile: /#{keyword}/i },
        { school: /#{keyword}/i }
      ]
    }).to_a
  end
end

  def self.update(id, name, age)
    COL.find(_id: BSON::ObjectId(id))
       .update_one({ '$set' => { name: name, age: age } })
  end

  def self.delete(id)
    COL.find(_id: BSON::ObjectId(id)).delete_one
  end

  def self.search(keyword)
    COL.find({ name: /#{keyword}/i }).to_a
  end
end
