#!/usr/bin/env ruby

class Volunteer
  attr_reader :id, :name, :project_id

  def initialize(attributes)
    @id = attributes[:id] || nil
    @name = attributes[:name]
    @project_id = attributes[:project_id]
  end
end
