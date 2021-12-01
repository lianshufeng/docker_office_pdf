# docker_office_pdf

- update
````shell
docker pull lianshufeng/office_pdf
````

- bash
````shell
docker run -it --rm lianshufeng/office_pdf /bin/bash
````

- version
````shell
docker run -it --rm lianshufeng/office_pdf soffice --version
docker run -it --rm lianshufeng/office_pdf convert --version
````

- word to pdf ( powershell + fonts )
````powershell
docker run -it --rm -v /C/Windows/Fonts:/usr/share/fonts/Fonts -v ${PWD}/work:/work lianshufeng/office_pdf  soffice --headless --invisible --convert-to pdf /work/in/1.docx --outdir /work/out/
````

- pdf to jpg
````shell
docker run -it --rm  -v ${PWD}/work:/work lianshufeng/office_pdf convert -quality 100 -geometry 1080 -density 300 "/work/out/1.pdf"  "/work/png/1.jpg" 
````

- docker.sock 
````shell
docker run -it --rm  -v /var/run/docker.sock:/var/run/docker.sock -v ${PWD}/work:/work centos:8 /bin/bash

# json tools
yum install jq -y 

# docker ps
curl -s --unix-socket /var/run/docker.sock http://localhost/images/json | jq




# create containers (to pdf)
ret=$( curl -s --unix-socket /var/run/docker.sock -H "Content-Type: application/json" http://localhost/containers/create -d '
{
	"Image": "lianshufeng/office_pdf",
	"HostConfig": { "Binds" : [ "/opt/docker/tmp/office/work:/work" ] , "AutoRemove":true },
	"Cmd": ["soffice","--headless","--invisible","--convert-to","pdf","/work/in/1.pptx","--outdir","/work/out/"]
}
' )
cid=$( jq -r  '.Id' <<< "${ret}" ) 
echo "${cid}"
# start containers
curl -s --unix-socket /var/run/docker.sock --request POST http://localhost/containers/${cid}/start
# wait containers
curl -s --unix-socket /var/run/docker.sock --request POST http://localhost/containers/${cid}/wait




# create containers (to jpg)
ret=$( curl -s --unix-socket /var/run/docker.sock -H "Content-Type: application/json" http://localhost/containers/create -d '
{
	"Image": "lianshufeng/office_pdf",
	"HostConfig": { "Binds" : [ "/opt/docker/tmp/office/work:/work" ] , "AutoRemove":true },
	"Cmd": ["convert","-quality","100","-geometry","1080","-density","300","/work/out/1.pdf","/work/jpg/1.jpg"]
}
' )
cid=$( jq -r  '.Id' <<< "${ret}" ) 
echo "${cid}"
# start containers
curl -s --unix-socket /var/run/docker.sock --request POST http://localhost/containers/${cid}/start
# wait containers
curl -s --unix-socket /var/run/docker.sock --request POST http://localhost/containers/${cid}/wait






# kill containers
curl -s --unix-socket /var/run/docker.sock --request DELETE http://localhost/containers/${cid}

````