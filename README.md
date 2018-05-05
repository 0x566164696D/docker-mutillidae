# docker-mutillidae
Dockerfile to run OWASP Mutillidae II https://sourceforge.net/projects/mutillidae/

# Steps

`sudo docker build . --force-rm -t cesena:mutillidae`

`sudo docker run -d -p 80:80 --name mutillidae cesena:mutillidae`

Connect to the docker IP and first perform the database population.