[Variables]
BarWidth=12
BarHeight=(#WORKAREAHEIGHT#/2)
BarGapX=4
BarGapY=0

FFTAttack=350
FFTDecay=350
FFTSize=2048
FreqMin=40
FreqMax=16000
; Audio settings
; http://docs.rainmeter.net/manual-beta/plugins/audiolevel#FFTOptions

MeasureName=MeasureAudioRepeat
MeterName=MeterBarRepeat

PlayerName=CAD
; The interface name for the media player
; http://docs.rainmeter.net/manual-beta/plugins/nowplaying#playerlist

Bands=96
Sensitivity=42
ColorIntensity=1.75
ColorTransitionTime=3.5

ColorPlaylist=AlbumArt
; ColorPlaylist=RandomColorPlaylist
; ColorPlaylist=ExampleColorPlaylist

; === DO NOT ADD VARIABLES BELOW THIS LINE ===

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
