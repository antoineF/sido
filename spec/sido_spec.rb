require File.dirname(__FILE__) + '/spec_helper'

set :environment, :test

describe "Sido" do
  include Rack::Test::Methods

  def app
    @app ||= Sinatra::Application
  end
  
  it "should redirect /" do
    get '/'
    last_response.status.should == 302
  end

  it "should respond to /projects" do
    get '/projects'
    last_response.should be_ok
  end
  
  it "should send 404 when project not exist" do
    get '/404'
    last_response.status == 404
  end
  
  it "should create project when download on new project" do
    post '/myproject/track'
    get '/myproject'
    last_response.status.should == 200
  end
  
  it "should return OK when add an event via the api" do
    post '/myproject/event', params={:name => "event1", :date => Date.today.strftime("%d/%m/%Y")}
    last_response.status.should == 200
    project = Project.where(:name => "myproject").first
    project.events_dataset.filter(:date => Date.today, :name => "event1").first.should_not be_nil
  end
  
  it "should redirect to project page when add an event" do
    post '/myproject/event', params={:name => "event2", :redirect => "True"}
    last_response.status.should == 302
    project = Project.where(:name => "myproject").first
    project.events_dataset.filter(:date => Date.today, :name => "event2").first.should_not be_nil
  end
  
  it "should return OK and increment when add a download count via the api" do
    count = Project.where(:name => "myproject").first.downloads_count
    post '/myproject/track', params={:version => "version1"}
    last_response.status.should == 200
    project = Project.where(:name => "myproject").first
    project.downloads_dataset.first.should_not be_nil
    project.downloads_dataset.filter(:version => "version1").count.should == 1 
    Project.where(:name => "myproject").first.downloads_count.should == count + 1
  end
  
  it "should redirect and increment when add a download count" do
    post '/myproject/track', params={:redirect => "True", :version => "version2"}
    last_response.status.should == 302
    project = Project.where(:name => "myproject").first
    downloads = project.downloads_dataset.filter(:version => "version2")
    downloads.should_not be_nil
    downloads.first.count.should == 1
  end
end