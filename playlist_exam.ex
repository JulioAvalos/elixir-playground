# playlist = %{
#   name: "Workout Mix",
#   tracks: [
#     %{id: 1, title: "Song A", liked: false},
#     %{id: 2, title: "Song B", liked: true},
#     %{id: 3, title: "Song C", liked: false}
#   ]
# }

# playlist = Playlist.like_track(playlist, 2);
# playlist = Playlist.like_track(playlist, 3);
# playlist = Playlist.add_track(playlist, "Song D");
# playlist = Playlist.add_track(playlist, "Song E");
# playlist = Playlist.add_track(playlist, "Song F");
# playlist = Playlist.add_track(playlist, "Song G");
# playlist = Playlist.like_track(playlist, 6);

defmodule Playlist do

  def like_track(playlist, track_id) do
    updated_tracks =
      Enum.map(
        playlist.tracks,
        fn track ->
          if track.id == track_id do
            %{track | liked: true}
          else
            track
          end
        end
      )
      %{playlist | tracks: updated_tracks}
  end

  def add_track(playlist, title) do
    max_id =
      playlist.tracks
      |> Enum.map(fn track -> track.id end)
      |> Enum.max(fn -> 0 end)

    next_id = max_id + 1

    new_track = %{
        id: next_id,
        title: title,
        liked: false
    }

    %{playlist | tracks: playlist.tracks ++ [new_track]}
  end

end
