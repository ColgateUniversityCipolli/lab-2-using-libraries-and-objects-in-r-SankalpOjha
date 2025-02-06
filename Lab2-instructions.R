###############################################################################
#LAB 2 (Tasks 1 & 2)
###############################################################################

library("stringr")

#TASK 1

#Finding the path for the files
(file.paths <- list.dirs(path = "Music", full.names = TRUE, recursive = TRUE))

#Sifting to find which elements in the vector which have two /
(album <- file.paths[which((str_count(file.paths, "/")) == 2)])

songnames.wav <- c()
full.file.location <- c()
code.to.process <- c()
song.name.nowav <- c()

for(i in 1:length(album)){
  #i=1
  track.files <- list.files(album[i])
  check.wav = str_count(track.files, pattern=".wav")
  songnames.wav = track.files[which(check.wav == 1)]
  
  for(y in 1:length(songnames.wav)){
    #y=1
    #load the current song to work on
    song.curr = songnames.wav[y] 
    #filename
    curr.info <- paste(album[i], "/", song.curr, sep = "") 
    #get song name without .WAV
    song.name.nowav <- str_sub(song.curr,
                               start = 1,
                               end = (length(song.curr)-6))
    #gather components for output file
    artist.name <- str_split_i(song.name.nowav, "-", 2)
    track.name <- str_split_i(song.name.nowav, "-", 3)
    album.name <- str_split_i(album[i], "/", 3)
    
    #combine components into one output
    track.name.json <- paste(track.name, ".json", sep = "")
    json.output <- paste(artist.name, album.name, track.name.json, sep = "-")
    
    #put into code.to.process
    code.to.process <- c(code.to.process,
                         paste("streaming_extractor_music.exe",
                               " ", '"', curr.info, 
                               '"', " ", '"', json.output, 
                               '"', sep = ""))
    }
}
writeLines(code.to.process, "batfile.txt")

#TASK 2

#extracting artist, album, and track
song.json <- list.files(pattern = ".json")
artist = str_split_i(song.json, "-", 1)
album = str_split_i(song.json, "-", 2)
find.track = str_split_1(song.json, "-")
track = str_sub(find.track[3], start = 0, end = -6)

#load JSON file
load.song.json <- fromJSON(song.json)

#extract data
average.loudness <- load.song.json$lowlevel$average_loudness
mean.spectral.energy <- load.song.json$lowlevel$spectral_energy$mean
danceability <- load.song.json$rhythm$danceability
bpm <- load.song.json$rhythm$bpm
key.key <- load.song.json$tonal$key_key
key.scale <- load.song.json$tonal$key_scale
length <- load.song.json$metadata$audio_properties$length
