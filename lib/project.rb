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
end
