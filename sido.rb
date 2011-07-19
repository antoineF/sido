# My first Ruby/Sinatra app, a download tracker.
# by Antoine Froissart (http://github.com/antoineF)

require 'rubygems'
require 'sinatra'
require 'sequel'
require 'haml'

configure :test do
  db = Sequel::DATABASES.first || Sequel.connect('sqlite:/')
  
  require 'sequel/extensions/migration'
  Sequel::Migrator.apply(db, 'db/migrations', 0, nil)
  Sequel::Migrator.apply(db, 'db/migrations')
end

configure :production, :development do
  db = Sequel.sqlite("db/downloads.db")
  
  require 'sequel/extensions/migration'
  Sequel::Migrator.apply(db, 'db/migrations')
end

configure do
  %w[download project event].each do |model|
    require "models/#{model}"
  end
  
  set :views, 'views/'
  
  #update projects downloads count....
  Project.each do |project|
    count = 0
    project.downloads.each do |download|
      count += download.count
    end
    project.update(:downloads_count=>count)
  end
end

require "sequel/extensions/pagination"
#helper
def update_or_create(projectname)
  project = Project.where(:name => projectname).first
  unless project
    project = Project.create(:name => projectname, :last_update => Time.now)
  else
    project.update(:last_update => Time.now)
  end
  return project
end

def date_to_time(date) Time.local(date.year, date.month, date.day) end

def create_download_list(projectname)
  now = Date.today;
  pastdate = now << 1
  project = Project.where(:name => projectname).first
  downloads = project.downloads_dataset.filter(:date >= pastdate)
  #event
  @events = project.events_dataset.filter(:date >= pastdate).order(:date)
  #version
  @versions = []
  downloads.each do |download|
    @versions.push(download.version) unless @versions.include? download.version
  end  
  #@versions = downloads.distinct(:version).get(:version)
  @completedownload = []
  @total_counts = []
  @versions.each do |version|
    download = []
    total_count = 0
    now = Date.today
    pastdate = now << 1
    while pastdate <= now do
      count = downloads.first(:date => pastdate, :version => version)
      unless count
        download.push([pastdate, 0])
      else
        total_count += count.count.to_i
        download.push([pastdate, count.count.to_i])
      end
      pastdate = pastdate + 1
    end
    @total_counts.push(total_count)
    @completedownload.push(download)
  end
end

def create_event(projectname, date, name)
  # Add an event for the project name
  project = update_or_create(projectname)
  # Add a line on the database id , :name
  project.add_event(Event.create(:date =>  date ? Date.strptime(date, "%d/%m/%Y") : Date.today, :name => name))
end  

#api
post '/:projectname/track' do
  # Add track event
  # create the project is not exist
  project = update_or_create(params[:projectname])
  # update the number ou create line if not exist (key = :projectname / :version)
  project.increment(params[:version].to_s.strip)
  redirect params[:projectname] if (params[:redirect])
end

post '/:projectname/event' do
  # Add an event for the project name
  create_event(params[:projectname], params[:date], params[:name])
  redirect params[:projectname] if (params[:redirect])
end

def paginate
  @paginated_rows = Project.reverse_order(:last_update).paginate(params[:page].to_i, 3)
end

def next_page
  !Project.reverse_order(:last_update).paginate(params[:page].to_i + 1, 3).empty?
end

def previous_page
  return false if params[:page] == "1"
  !Project.reverse_order(:last_update).paginate(params[:page].to_i - 1, 3).empty?
end

#client
get '/' do
  redirect '/projects'
end

get '/projects' do
  # Return all the project
  # Get the project list from the db, create link
  params[:page] = "1"
  paginate
  haml :index
end

get '/projects/:page' do
  paginate
  haml :index
end

get '/:projectname' do
  # Show chart of download for the project
  # Use template js + flow
  @project = Project.where(:name => params[:projectname]).first
  return 404 unless @project
  # get project from the current month + separate from version
  # @downloads = project.downloads
  create_download_list(params[:projectname])
  haml :project
end