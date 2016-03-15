require "open-uri"

class PosterController < ApplicationController

  def show
    imdbId = params[:imdbId]
    filename = "public/posters/" + imdbId + ".jpeg"

    if !File.file?(filename)
      download_image(imdbId)
    end

    send_file(
      "public/posters/" + imdbId + ".jpeg",
      type: "image/jpeg",
      x_sendfile: true
    )
  end

  private
    def download_image(imdbId)
      url = "http://img.omdbapi.com/?i=" + imdbId  + "&apikey=" + Rails.application.secrets.omdb_api_key
      localPath = "public/posters/" + imdbId + ".jpeg"

      File.open(localPath, "wb") do |saved_file|
        open(url, "rb") do |read_file|
          saved_file.write(read_file.read)
        end
      end
    end

end
