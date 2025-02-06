###############################################################################
#LAB 2 (Tasks 1 & 2)
###############################################################################

library("stringr")

#Finding the path for the files
(file.paths <- list.dirs(path = "Music", full.names = TRUE, recursive = TRUE))
list.files(path = "Music")

#Sifting to find which elements in the vector which have two /
(album <- which((str_count(file.paths, "/")) == 2))
songnames <- c()
full.file.location <- c()
code.to.process <- c()
song.name.nowav <- c()

for(i in 1:length(album)){
  track.files <- list.files(path = file.paths[album[i]])
  # filter to ensure the files are .wav files
  for(y in 1:length(track.files)){
    songnames = c(songnames, track.files[y])
    song.name.nowav <- c(song.name.nowav, 
                         str_sub(songnames[i], 
                                 start = 1, 
                                 end = (length(songnames[i])-6)))
    full.file.location <- c(full.file.location, paste(file.paths[album[i]], 
                                                track.files[y],
                                                sep = "/"))
  }
}
(songnames)
(full.file.location)



for(i in 1:length(songnames)){
  song.name.nowav <- c(song.name.nowav, 
                       str_sub(songnames[i], 
                               start = 1, 
                               end = (length(songnames[i])-6)))
  
  for (j in 1:length(song.name.nowav)){
    #Step C
    artist <- str_split_i(song.name.nowav[j], "-", 2)
    album <- str_split_i(full.file.location[j], "/", 3)
    track <- str_split_i(song.name.nowav[j], "-", 3)
    json.artist <- paste(track, ".json", sep = "")
    json.file <- paste(artist, album, json.artist, sep = "-")
    #Step D
    final <- paste("streaming_extractor_music.exe", " ", 
                   '"', full.file.location, '"', " ", '"', json.file,
                   '"', sep = "")
    code.to.process = c(code.to.process, final)
  }
}
(song.name.nowav)

writeLines(code.to.process, "batfile.txt")









