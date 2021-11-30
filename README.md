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

- pdf to png
````shell
docker run -it --rm -v ${PWD}/work:/work lianshufeng/office_pdf  convert  -quality 100 -density 300 "/work/out/1.pdf"  "/work/out/png/1.png"
````
