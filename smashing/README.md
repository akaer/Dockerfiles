Sample:

  sudo docker run --dns="8.8.8.8" -it --rm=true --name dashboard -v /etc/localtime:/etc/localtime:ro -p 3030:3030 -e GEMS="xml-simple sinatra_cyclist tiny_tds" -e WIDGETS="cbc8dbab10df8c48485f15dd9d7e9a88 4990174 667cc198fa30d7f7d313 fa416040ca2ce7c1934a"

