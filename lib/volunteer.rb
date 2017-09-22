#!/usr/bin/env ruby

class Volunteer
  attr_reader :id, :name, :project_id

  def initialize(attributes)
    @id = attributes[:id] || nil
    @name = attributes[:name]
    @project_id = attributes[:project_id]
  end

  def ==(other_volunteer)
    @name == other_volunteer.name
  end
end
