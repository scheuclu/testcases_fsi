#/usr/bin/bash!

#xargs essentially runs a command once for each of its instructions from standard input

printf "\033[1;4;92mDELETING THE FOLLOWING                                                          \033[00m\n"
find . -type d -name 'fdsim_*'
find . -type d -name 'anasim_*'
find . -name 'info'

find . -type d -name 'fdsim_*' | xargs rm -rf
find . -type d -name 'anasim_*' | xargs rm -rf
find . -name 'info' | xargs rm -f
printf "\033[1;4;92m                                                                                \033[00m\n"
