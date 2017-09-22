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
