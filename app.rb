require "sinatra"
require "sinatra/reloader"
also_reload "lib/**/*.rb"
require "pg"
require "./lib/project"
require "./lib/volunteer"
require "pry"

DB = PG.connect({:dbname => 'volunteer_tracker_test'})

get('/') do
  @section = 'home'
  @projects = Project.all
  erb(:index)
end

post('/add-project') do
  title = params["title"]
  project = Project.new({title: title})
  project.save
  redirect '/'
end

get('/projects/:id') do
  @section = 'projects'
  @project = Project.find(params[:id].to_i)
  erb(:project)
end

get('/projects/:id/edit') do
  @section = 'projects'
  @project = Project.find(params[:id].to_i)
  erb(:edit)
end

patch('/projects/:id/edit') do
  project = Project.find(params[:id].to_i)
  project.update({title: params["title"]})
  redirect "/projects/#{project.id}"
end

delete('/projects/:id/delete') do
  project = Project.find(params[:id].to_i)
  project.delete
  redirect '/'
end

post('/add-volunteer') do
  name = params["name"]
  project_id = params["project-id"].to_i
  volunteer = Volunteer.new({name: name, project_id: project_id})
  volunteer.save
  redirect '/'
end

get('/volunteers/:id') do
  @section = 'volunteers'
  @volunteer = Volunteer.find(params[:id].to_i)
  @projects = Project.all
  erb(:volunteer)
end

patch('/volunteers/:id/edit') do
  volunteer = Volunteer.find(params[:id].to_i)
  volunteer.update({name: params["name"], project_id: params["project-id"].to_i})
  redirect "/projects/#{volunteer.project_id}"
end

delete('/volunteers/:id/delete') do
  volunteer = Volunteer.find(params[:id].to_i)
  volunteer.delete
  redirect "/projects/#{volunteer.project_id}"
end
