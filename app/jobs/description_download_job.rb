class DescriptionDownloadJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    titles = Title.where(description: nil).take(10)
    titles.each do |t|
      TitlesHelper.download_description(t)
    end
    puts "Downloaded #{titles.count} titles·"
  end
  
end
