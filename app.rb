require 'sinatra/base'
require 'sinatra/namespace'
require 'sinatra/activerecord'

class StationSerializer
  def initialize(station)
    @station = station
  end

  def as_json(*)
    {
      id: @station.id,
      name: @station.name,
      url: @station.url
    }
  end
end

class EpisodeSerializer
  def initialize(episode)
    @episode = episode
  end

  def as_json(*)
    {
      place:            @episode.place,
      id:               @episode.id,
      station_id:       @episode.station_id,
      artist:           @episode.artist,
      title:            @episode.title,
      previous_place:   @episode.previous_place,
      sc_id:            @episode.sc_id,
      sc_title:         @episode.sc_title,
      sc_duration:      @episode.sc_duration/1000,
      sc_stream_url:    @episode.sc_stream_url,
      sc_image_url:     @episode.sc_image_url,
      sc_download_url:  @episode.sc_download_url
    }
  end
end

class Station < ActiveRecord::Base
  has_many :episodes
end
class Episode < ActiveRecord::Base
  belongs_to :station
end

class App < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  register Sinatra::Namespace

  configure :production, :development do
    URI.parse(ENV['DATABASE_URL'] || 'postgres://localhost/winamp_api_development')
  end

  namespace '/api/v1' do
    before do
      content_type :json
    end

    get '/stations' do
      stations = Station.all.order(:id)
      stations.map { |station| StationSerializer.new(station) }.to_json
    end

    get '/stations/:id/episodes' do |id|
      episodes = Episode.where(station_id: id, in_top: true).order(:place)
      episodes.map { |episode| EpisodeSerializer.new(episode) }.to_json
    end
  end

  after do
    # Close the connection after the request is done so that we don't
    # deplete the ActiveRecord connection pool.
    ActiveRecord::Base.connection.close
  end
end

