require 'httparty'
require 'soundcloud'

class UpdateFeed
  CLIENT_ID = 'f4323c6f7c0cd73d2d786a2b1cdae80c'.freeze

  def self.run
    Station.all.each do |station|
      self.new(station).download
    end
  end


  def initialize(station)
    @sc_client = SoundCloud.new(client_id: UpdateFeed::CLIENT_ID)
    @station = station
    @episodes = station.episodes
  end

  def download
    response = HTTParty.get(@station.url)

    songs = response['songs']

    @episodes.update(in_top: false)

    songs.each do |song_attrs|
      _attrs = song_attrs.slice('artist', 'title', 'place', 'previousPlace')

      episode = @episodes.find_by(artist: _attrs['artist'], title: _attrs['artist'])
      if episode
        update_place_only(episode, _attrs)
      else
        create_new_episode(_attrs)
      end
    end
  end

  private

  def update_place_only(episode, attrs)
    episode.update_attributes({
      in_top: true,
      place: attrs['place'],
      previous_place: attrs['previousPlace']
    })
  end

  def create_new_episode(attrs)
    tracks = @sc_client.get('/tracks', q: attrs['artist'] +' - '+ attrs['artist'] )
    detected_track = tracks[0]

    if detected_track.present?

      episode_attributes = {
        in_top: true,
        artist: attrs['artist'],
        title: attrs['title'],
        place: attrs['place'],
        previous_place: attrs['previousPlace'],
        sc_id: detected_track.id,
        sc_title: detected_track.title,
        sc_duration: detected_track.duration,
        sc_stream_url: detected_track.stream_url + "?client_id=#{UpdateFeed::CLIENT_ID}",
        sc_image_url: detected_track.artwork_url,
        sc_download_url: (detected_track.downloadable ? (detected_track.download_url + "?client_id=#{UpdateFeed::CLIENT_ID}") : nil)
      }

      @station.episodes.create(episode_attributes)
    end
  end
end
