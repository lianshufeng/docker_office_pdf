# docker_office_pdf

- bash
````shell
docker run -it --rm -v /C/Windows/Fonts:/usr/local/fonts lianshufeng/office_pdf /bin/bash
````

- word to pdf (powershell)
````powershell
docker run -it --rm -v /C/Windows/Fonts:/usr/local/fonts -v ${PWD}/in:/work/in -v ${PWD}/out:/work/out lianshufeng/office_pdf  soffice --headless --invisible --convert-to pdf /work/in/1.pptx --outdir /work/out
````
