module PostersHelper
  def download_poster(imdbId)
    url = "http://img.omdbapi.com/?i=" + imdbId  + "&apikey=" + Rails.application.secrets.omdb_api_key
    localPath = "public/posters/" + imdbId + ".jpeg"

    File.open(localPath, "wb") do |saved_file|
      open(url, "rb") do |read_file|
        saved_file.write(read_file.read)
      end
    end
  end
end
