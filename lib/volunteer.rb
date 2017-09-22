#!/usr/bin/env ruby

class Volunteer
  attr_reader :id, :name, :project_id

  def initialize(attributes)
    @id = attributes[:id] || nil
    @name = attributes[:name]
    @project_id = attributes[:project_id]
  end

  def save
    results = DB.exec("INSERT INTO volunteers (name, project_id) VALUES ('#{@name}', #{@project_id}) RETURNING id;")
    @id = results.first["id"].to_i
  end

  def update(attributes)
    @name = attributes[:name]
    @project_id = attributes[:project_id]
    DB.exec("UPDATE volunteers SET name = '#{@name}', project_id = #{@project_id} WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM volunteers WHERE id = #{@id};")
  end

  def ==(other_volunteer)
    @name == other_volunteer.name
  end

  def self.all
    results = DB.exec("SELECT * FROM volunteers;")
    results.map do |result|
      Volunteer.new({
        id: result["id"].to_i,
        name: result["name"],
        project_id: result["project_id"].to_i
      })
    end
  end

  def self.find(id)
    results = DB.exec("SELECT * FROM volunteers WHERE id = #{id};")
    if results.any?
      return Volunteer.new({
        id: results.first["id"].to_i,
        name: results.first["name"],
        project_id: results.first["project_id"].to_i
      })
    end
  end

  def self.search(name)
    volunteers = Volunteer.all
    volunteers.select do |volunteer|
      volunteer.name.downcase == name.downcase
    end
  end
end
