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

for(i in 1:length(album)){
  track.files <- list.files(path = file.paths[album[i]])
  # filter to ensure the files are .wav files
  for(y in 1:length(track.files)){
    songnames = c(songnames, track.files[y])
    full.file.location <- c(full.file.location, paste(file.paths[album[i]], 
                                                track.files[y],
                                                sep = "/"))
  }
}
(songnames)
(full.file.location)

song.name.nowav <- c()
song.name.justtrack <- c()

for(i in 1:length(songnames)){
  song.name.nowav <- c(song.name.nowav, str_sub(full.file.location[i], start = 1, 
                               end = (length(full.file.location[i])-6)))
  song.name.justtrack <- c(song.name.justtrack, 
                           str_split_1(str_sub(song.name.nowav[i], 
                                               start = 1,
                                               end = (length(song.name.nowav[i])-6)),
                                               "-"))
}
(song.name.nowav)
(song.name.justtrack)