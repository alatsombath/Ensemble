-- ColorChanger v2.1, A modification of ColorChanger v1.3 by Smurfier
-- LICENSE: Creative Commons Attribution-Non-Commercial-Share Alike 3.0

local Colors,ColorsIdx,Out,VarColors,Mode,Check,Measure,Meter,random={},{},{},{},{},{},{},{},math.random
function Initialize()
	Counter,TransitionTime=0,math.floor((SKIN:ReplaceVariables("#ColorTransitionTime#")*1000)/16)
	Sub,Index,Limit,Amp=SELF:GetOption("Sub"),SKIN:ParseFormula(SELF:GetOption("Index")),SKIN:ParseFormula(SELF:GetOption("Limit")),SKIN:ReplaceVariables("#ColorIntensity#")
	local MeasureName,MeterName,gsub=SKIN:ReplaceVariables("#MeasureName#"),SKIN:ReplaceVariables("#MeterName#"),string.gsub
	for i=Index,Limit do Measure[i]=SKIN:GetMeasure((gsub(MeasureName,Sub,i))) Meter[i]=(gsub(MeterName,Sub,i)) end
	ColorsInfoPath=SKIN:GetMeasure("MeasureParseImgColors")
	Playlist(SKIN:ReplaceVariables("#ColorPlaylist#")) end
	
function Playlist(Name)
	if Name=="AlbumArt" then return end
	local PlaylistMeasure,j=SKIN:GetMeasure(Name),1 while PlaylistMeasure:GetOption(j)~="" do j=j+1 end Total=j-1
	AlbumArtMode,Shuffle=0,PlaylistMeasure:GetNumberOption("Shuffle") if Shuffle==1 then Idx=random(1,Total) Next=random(1,Total) else Idx,Next=1,2 end
	local SplitColors,Sub,Index,Limit,find,gmatch={},Sub,Index,Limit,string.find,string.gmatch
	for j=1,Total do
		Colors[j],ColorsIdx[j],VarColors[j],SplitColors[j],Out[j],Mode[j]={},{},{},{},PlaylistMeasure:GetOption("Out"..j),PlaylistMeasure:GetOption("Mode"..j)
		local ColorsStr,a=SKIN:ReplaceVariables(PlaylistMeasure:GetOption(j)),1 for b in gmatch(ColorsStr,"[^%|]+") do SplitColors[j][a]=b a=a+1 end
		if Out[j]=="Meter" then Check[j]=3 elseif Out[j]~="" then Check[j]=1 if find(Out[j],Sub) then Check[j]=2 for i=Index,Limit do VarColors[j][i]={} end end
		else Check[j]=0 end if find(ColorsStr,Sub) then Check[j]={} end
		for a=1,2 do Colors[j][a]={} ColorsIdx[j][a]={} local b=1 for c in gmatch(SplitColors[j][a],"[^,]+") do ColorsIdx[j][a][b]=c b=b+1 end
			for d=1,3 do if ColorsIdx[j][a][d]=="Random" then Colors[j][a][d]=random(0,255) else Colors[j][a][d]=ColorsIdx[j][a][d] end end
			for k=1,Total do if SplitColors[j][a]==Out[k] then Colors[j][a]=VarColors[k] if Check[k]==2 then Check[j][a]=1 end break end end end end end

function AlbumArt()
	AlbumColors,Colors,VarColors,AlbumArtMode,Idx,Next,Total={},{},{},1,-1,-1,5
	local RawAlbumColors,a,gmatch,Info={},1,string.gmatch,io.input(ColorsInfoPath:GetStringValue()):read("*all")
	for b in gmatch(Info,"rgb (.-) hex") do RawAlbumColors[a]=b a=a+1 end
	for a=25,26 do for b in gmatch(RawAlbumColors[a],"value (.-) rgb") do RawAlbumColors[a]=b end end
	local AlbumColorsIdx={1,2,5,6,9,10,25,26,29,30}
	for a=1,10 do AlbumColors[a]={} local b=1 for c in gmatch(RawAlbumColors[AlbumColorsIdx[a]],"[^,]+") do AlbumColors[a][b]=c b=b+1 end end
	
	for j=1,3 do Check[j],Out[j],Colors[j],VarColors[j],Mode[j]=1,-1,{},{},"RightToLeft"
		for a=1,2 do Colors[j][a]={} local ColorsTable=AlbumColors[random(1,10)] for b=1,3 do Colors[j][a][b]=ColorsTable[b] end end end
	Check[4],Out[4],Colors[4],VarColors[4]=2,-1,{},{} Colors[4][1],Colors[4][2]=VarColors[1],VarColors[2] for i=Index,Limit do VarColors[4][i]={} end
	Check[5],Out[5],Colors[5]={},-1,{} Check[5][2],Colors[5][1],Colors[5][2]=1,VarColors[3],VarColors[4] end
			
local function Transition(j)
	if AlbumArtMode==1 and Mode[j]=="RightToLeft" then local ColorsTable=AlbumColors[random(1,10)]
		for a=1,3 do Colors[j][1][a]=Colors[j][2][a] Colors[j][2][a]=ColorsTable[a] end
	elseif Mode[j]=="RightToLeft" then for a=1,3 do Colors[j][1][a]=Colors[j][2][a]
		if ColorsIdx[j][2][a]=="Random" then Colors[j][2][a]=random(0,255) else Colors[j][2][a]=ColorsIdx[j][2][a] end end
	elseif j==Idx and Out[j]=="" then for a=1,2 do for b=1,3 do
		if ColorsIdx[j][a][b]=="Random" then Colors[j][a][b]=random(0,255) else Colors[j][a][b]=ColorsIdx[j][a][b] end end end end end
		
function Update() if Total then
	Counter=Counter+1 if Counter==TransitionTime then Counter=0 for j=1,Total do Transition(j) end if Shuffle==1 then Idx=Next Next=random(1,Total)
		else Idx,Next=Idx+1,Next+1 if Idx>Total then Idx,Next=1,2 elseif Next>Total then Next=1 end end end
	local Idx,Next,Amp,Index,Limit=Idx,Next,Amp,Index,Limit
	for j=1,Total do 
		local function Main(Colors1,Colors2,i)
			if i~=-1 then if Check[j]==2 then local c=(i-Index)%Limit local b=Limit-c
				for k=1,3 do VarColors[j][i][k]=(Colors1[k]*b+Colors2[k]*c)/Limit end return VarColors[j][i]
				
				else local AmpValue=Amp*Measure[i]:GetValue() if AmpValue>1 then AmpValue=1 end
				local ColorsTable,b={},1-AmpValue for k=1,3 do ColorsTable[k]=Colors1[k]*b+Colors2[k]*AmpValue end
				SKIN:Bang("!SetOption",Meter[i],"BarColor",table.concat(ColorsTable,",")) end
				
			elseif Mode[j]=="RightToLeft" then local b=TransitionTime-Counter
				for k=1,3 do VarColors[j][k]=(Colors1[k]*b+Colors2[k]*Counter)/TransitionTime end
			elseif j==Idx then local ColorsTable,b={},TransitionTime-Counter
				for k=1,3 do ColorsTable[k]=(Colors1[k]*b+Colors2[k]*Counter)/TransitionTime end return ColorsTable end end
		
		if j==Idx and Out[j]=="" then local ColorsTable,DoubleCheck,k={},{},Next for a=1,2 do
			if Check[j]==0 and Check[k]==0 then ColorsTable[a]=Main(Colors[j][a],Colors[k][a],-1)
			elseif Check[j][a] and Check[k][a] then ColorsTable[a],DoubleCheck[a]={},1
				for i=Index,Limit do if Measure[i]:GetValue()~=0 then ColorsTable[a][i]=Main(Colors[j][a][i],Colors[k][a][i],i) end end
			elseif Check[j][a] then ColorsTable[a],DoubleCheck[a]={},1
				for i=Index,Limit do if Measure[i]:GetValue()~=0 then ColorsTable[a][i]=Main(Colors[j][a][i],Colors[k][a],i) end end
			elseif Check[k][a] then ColorsTable[a],DoubleCheck[a]={},1
				for i=Index,Limit do if Measure[i]:GetValue()~=0 then ColorsTable[a][i]=Main(Colors[j][a],Colors[k][a][i],i) end end end end
			
			if Check[j]==0 and Check[k]==0 then for i=Index,Limit do if Measure[i]:GetValue()~=0 then Main(ColorsTable[1],ColorsTable[2],i) end end
			elseif DoubleCheck[1] and DoubleCheck[2] then for i=Index,Limit do if Measure[i]:GetValue()~=0 then Main(ColorsTable[1][i],ColorsTable[2][i],i) end end
			elseif DoubleCheck[1] then for i=Index,Limit do if Measure[i]:GetValue()~=0 then Main(ColorsTable[1][i],ColorsTable[2],i) end end
			elseif DoubleCheck[2] then for i=Index,Limit do if Measure[i]:GetValue()~=0 then Main(ColorsTable[1],ColorsTable[2][i],i) end end end
		
		elseif Check[j]==0 or Check[j]==1 then Main(Colors[j][1],Colors[j][2],-1)
		elseif Check[j]==2 or Check[j]==3 then for i=Index,Limit do if Measure[i]:GetValue()~=0 then Main(Colors[j][1],Colors[j][2],i) end end
		elseif Check[j][1] and Check[j][2] then for i=Index,Limit do if Measure[i]:GetValue()~=0 then Main(Colors[j][1][i],Colors[j][2][i],i) end end
		elseif Check[j][1] then for i=Index,Limit do if Measure[i]:GetValue()~=0 then Main(Colors[j][1][i],Colors[j][2],i) end end
		elseif Check[j][2] then for i=Index,Limit do if Measure[i]:GetValue()~=0 then Main(Colors[j][1],Colors[j][2][i],i) end end end end end end