# docker_office_pdf

- update
````shell
docker pull lianshufeng/office_pdf
````

- bash
````shell
docker run -it --rm lianshufeng/office_pdf /bin/bash
````

- word to pdf ( powershell + fonts )
````powershell
docker run -it --rm -v /C/Windows/Fonts:/usr/share/fonts/Fonts -v ${PWD}/work:/work lianshufeng/office_pdf  soffice --headless --invisible --convert-to pdf /work/in/1.docx --outdir /work/out/
````
