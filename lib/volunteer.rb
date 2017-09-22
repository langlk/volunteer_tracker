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
end
