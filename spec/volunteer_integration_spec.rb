require "capybara/rspec"
require "./app"
require "pry"
require('spec_helper')

Capybara.app = Sinatra::Application
set(:show_exceptions, false)

# Your project should be set up so that a volunteer can only be created if a project already exists. (This makes it easier to assign the one to many relationship in Sinatra.) Focus on getting one integration spec passing at a time.

# The user should be able to visit the home page and fill out a form to add a new project. When that project is created, the application should direct them back to the homepage.

describe 'the project creation path', {:type => :feature} do
  it 'takes the user to the homepage where they can create a project' do
    visit '/'
    fill_in('title', :with => 'Teaching Kids to Code')
    click_button('Create Project')
    expect(page).to have_content('Teaching Kids to Code')
  end
end

# A user should be able to click on a project to see its detail. The detail page includes a form where the project can be updated. When the form is submitted, the user can be directed to either the home page or that project's detail page. (The test will work for either.)

describe 'the project update path', {:type => :feature} do
  it 'allows a user to change the name of the project' do
    test_project = Project.new({:title => 'Teaching Kids to Code', :id => nil})
    test_project.save
    visit '/'
    click_link('Teaching Kids to Code')
    click_link('Edit Project')
    fill_in('title', :with => 'Teaching Ruby to Kids')
    click_button('Update Project')
    expect(page).to have_content('Teaching Ruby to Kids')
  end
end

# A user should be able to nagivate to a project's detail page and delete the project. The user will then be directed to the index page. The project should no longer be on the list of projects.

describe 'the project delete path', {:type => :feature} do
  it 'allows a user to delete a project' do
    test_project = Project.new({:title => 'Teaching Kids to Code', :id => nil})
    test_project.save
    id = test_project.id
    visit "/projects/#{id}/edit"
    click_button('Delete Project')
    visit '/'
    expect(page).not_to have_content("Teaching Kids to Code")
  end
end

# The user should be able to click on a project detail page and see a list of all volunteers working on that project. The user should be able to click on a volunteer to see the volunteer's detail page.

describe 'the volunteer detail page path', {:type => :feature} do
  it 'shows a volunteer detail page' do
    test_project = Project.new({:title => 'Teaching Kids to Code', :id => nil})
    test_project.save
    project_id = test_project.id.to_i
    test_volunteer = Volunteer.new({:name => 'Jasmine', :project_id => project_id, :id => nil})
    test_volunteer.save
    visit "/projects/#{project_id}"
    click_link('Jasmine')
    fill_in('name', :with => 'Jane')
    click_button('Update Volunteer')
    expect(page).to have_content('Jane')
  end
end

# Expanding Volunteer to have full CRUD functionality

describe 'the volunteer delete path', {:type => :feature} do
  it "allows a user to delete a volunteer" do
    test_project = Project.new({:title => 'Teaching Kids to Code', :id => nil})
    test_project.save
    project_id = test_project.id.to_i
    test_volunteer = Volunteer.new({:name => 'Jasmine', :project_id => project_id, :id => nil})
    test_volunteer.save
    visit "/projects/#{project_id}"
    click_link('Jasmine')
    click_button('Delete Volunteer')
    expect(page).to have_no_content('Jasmine')
  end
end

# Search Functionality

describe 'the project search path', {:type => :feature} do
  it "allows a user to search for a project" do
    test_project = Project.new({:title => 'Teaching Kids to Code', :id => nil})
    test_project.save
    id = test_project.id
    visit('/projects/all')
    fill_in('search-term', with: "Teaching Kids to Code")
    click_button('search', :id)
    expect(page).to have_content('Search Results: Teaching Kids to Code')
  end
end

describe 'the volunteer search path', {:type => :feature} do
  it "allows a user to search for a project" do
    test_project = Project.new({:title => 'Teaching Kids to Code', :id => nil})
    test_project.save
    project_id = test_project.id.to_i
    test_volunteer = Volunteer.new({:name => 'Jasmine', :project_id => project_id, :id => nil})
    test_volunteer.save
    visit('volunteers/all')
    fill_in('search-term', with: "Jasmine")
    click_button('search', :id)
    expect(page).to have_content('Search Results: Jasmine')
  end
end

# Adding Volunteer List Page

describe 'the volunteer list path', {:type => :feature} do
  it "shows all volunteers in alphabetical order by name" do
    test_project = Project.new({:title => 'Teaching Kids to Code', :id => nil})
    test_project.save
    project_id = test_project.id.to_i
    volunteer1 = Volunteer.new({:name => 'Jasmine', :project_id => project_id, :id => nil})
    volunteer1.save
    volunteer2 = Volunteer.new({:name => 'Adam', :project_id => project_id, :id => nil})
    volunteer2.save
    volunteer3 = Volunteer.new({:name => 'Chris', :project_id => project_id, :id => nil})
    volunteer3.save
    visit('/volunteers/all')
    expect(page).to have_content('Adam Chris Jasmine')
  end
end

describe 'the project list path', {:type => :feature} do
  it "shows all projects in alphabetical order by title" do
    project1 = Project.new({:title => 'Teaching Kids to Code', :id => nil})
    project1.save
    project2 = Project.new({:title => 'Cleaning up Neighborhood Parks', :id => nil})
    project2.save
    project3 = Project.new({:title => 'Assisting Food Bank', :id => nil})
    project3.save
    visit('/projects/all')
    expect(page).to have_content("Teaching Kids to Code Cleaning up Neighborhood Parks Assisting Food Bank")
  end
end
