#!/usr/bin/env ruby

class Project
  attr_reader :title, :id

  def initialize(attributes)
    @title = attributes[:title]
    @id = attributes[:id] || nil
  end

  def save
    results = DB.exec("INSERT INTO projects (title) VALUES ('#{@title}') RETURNING id;")
    @id = results.first["id"].to_i
  end

  def volunteers
    results = DB.exec("SELECT * FROM volunteers WHERE project_id = #{@id}")
    results.map do |result|
      Volunteer.new({
        id: result["id"].to_i,
        name: result["name"],
        project_id: result["project_id"].to_i
      })
    end
  end

  def update(attributes)
    @title = attributes[:title]
    DB.exec("UPDATE projects SET title = '#{@title}' WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM volunteers WHERE project_id = #{@id};")
    DB.exec("DELETE FROM projects WHERE id = #{@id};")
  end

  def ==(other_project)
    @title == other_project.title
  end

  def self.all
    results = DB.exec("SELECT * FROM projects;")
    results.map do |result|
      Project.new({
        title: result["title"],
        id: result["id"].to_i
      })
    end
  end

  def self.find(id)
    results = DB.exec("SELECT * FROM projects WHERE id = #{id};")
    if results.any?
      return Project.new({
        title: results.first["title"],
        id: results.first["id"]
      })
    end
  end
end
