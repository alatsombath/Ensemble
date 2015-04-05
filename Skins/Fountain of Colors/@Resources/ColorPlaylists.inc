[ExampleColorPlaylist]
Measure=String

Shuffle=0

; R,G,B color format
; Color for quiet sounds | Color for loud sounds
1=255,0,0|255,255,255
2=255,165,0|255,255,255
3=255,255,0|255,255,255
4=0,255,0|255,255,255
5=0,0,255|255,255,255
6=255,0,255|255,255,255

[ExampleColorPlaylist2]
Measure=String

Shuffle=1

1=Random,Random,Random|Random,Random,Random
2=Random,Random,Random|Random,Random,Random
3=Random,Random,Random|Random,Random,Random

[ArtistColorSettings]
Measure=String
String=[MeasureArtist]
DynamicVariables=1

; IfMatchN=ARTIST_NAME$
; IfMatchActionN[!CommandMeasure ScriptColorFactory """Playlist("PLAYLIST_NAME")"""]

IfMatch=The Beatles$
; DO NOT REMOVE "$" symbol, DO NOT ADD "" quotes
IfMatchAction=[!CommandMeasure ScriptColorFactory """Playlist("ExampleColorPlaylist")"""]
; DO NOT REMOVE """ quotes

IfMatch2=Led Zeppelin$
IfMatchAction2=[!CommandMeasure ScriptColorFactory """Playlist("ExampleColorPlaylist")"""]

IfMatch3=Coldplay$
IfMatchAction3=[!CommandMeasure ScriptColorFactory """Playlist("ExampleColorPlaylist")"""]

[AlbumColorSettings]
Measure=String
String=[MeasureAlbum]
DynamicVariables=1

; IfMatchN=ALBUM_NAME$
; IfMatchActionN[!CommandMeasure ScriptColorFactory """Playlist("PLAYLIST_NAME")"""]

IfMatch=Hotel California$
IfMatchAction=[!CommandMeasure ScriptColorFactory """Playlist("ExampleColorPlaylist")"""]

IfMatch2=The Dark Side of the Moon$
IfMatchAction2=[!CommandMeasure ScriptColorFactory """Playlist("ExampleColorPlaylist")"""]

IfMatch3=Moonmadness$
IfMatchAction3=[!CommandMeasure ScriptColorFactory """Playlist("ExampleColorPlaylist")"""]

[TrackColorSettings]
Measure=String
String=[MeasureTrack]
DynamicVariables=1

; IfMatchN=TRACK_NAME$
; IfMatchActionN[!CommandMeasure ScriptColorFactory """Playlist("PLAYLIST_NAME")"""]

IfMatch=Mr. Blue Sky$
IfMatchAction=[!CommandMeasure ScriptColorFactory """Playlist("ExampleColorPlaylist")"""]

IfMatch2=Here Comes the Sun$
IfMatchAction2=[!CommandMeasure ScriptColorFactory """Playlist("ExampleColorPlaylist")"""]

IfMatch3=Make It with You$
IfMatchAction3=[!CommandMeasure ScriptColorFactory """Playlist("ExampleColorPlaylist")"""]

[RandomColorPlaylist]
; For advanced users
Measure=String

1=Random,Random,Random|Random,Random,Random
; Transition this color string from right to left
Mode1=RightToLeft
; Output to a temporary variable, for use in the next sequence
Out1=Left

2=Random,Random,Random|Random,Random,Random
Mode2=RightToLeft
Out2=Right

3=Random,Random,Random|Random,Random,Random
Out3=Bottom
Mode3=RightToLeft

4=Left|Right
; Output to a table of interpolated colors, one specific color for each bar/band
Out4=TopRepeat

5=Bottom|TopRepeat
; Output to display
Out5=Meter