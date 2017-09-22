require "sinatra"
require "sinatra/reloader"
also_reload "lib/**/*.rb"
require "pg"
require "./lib/project"
require "./lib/volunteer"
require "pry"

DB = PG.connect({:dbname => 'volunteer_tracker_test'})

get('/') do
  @projects = Project.all
  erb(:index)
end

post('/') do
  title = params["title"]
  project = Project.new({title: title})
  project.save
  redirect '/'
end

get('/projects/:id') do
  @project = Project.find(params[:id].to_i)
  erb(:project)
end

get('/projects/:id/edit') do
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
