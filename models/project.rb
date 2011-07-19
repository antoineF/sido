class Project < Sequel::Model
  one_to_many :downloads
  one_to_many :events

  def date
    self.last_update.strftime("%Y-%m-%d %H:%M:%S")
  end
  
  def increment(version)
    #find download for version / date
    download = self.downloads_dataset.filter(:version => version, :date => Date.today).first
    unless download
      download = Download.create(:version => version, :date => Date.today, :count => 1)
      self.add_download(download)
    else
      download.increment()
    end
    #increment download count
    self.update(:downloads_count => self.downloads_count+1)
  end
end