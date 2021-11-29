FROM centos:8 as build
MAINTAINER lianshufeng <251708339@qq.com>
ARG LibreOffice_URL="https://web.api.jpy.wang/LibreOffice/LibreOffice_7.2.3_Linux_x86-64_rpm.tar.gz"
ARG LibreOffice_File="LibreOffice_7.2.3.2_Linux_x86-64_rpm"


# download
RUN curl $LibreOffice_URL -o /tmp/LibreOffice_rpm.tar.gz
RUN cd /tmp/ ; tar xvzf LibreOffice_rpm.tar.gz 


FROM centos:8 as runtime
ARG LibreOffice_File="LibreOffice_7.2.3.2_Linux_x86-64_rpm"
ARG LibreOffice_Home="/opt/libreoffice7.2"

# setup
COPY --from=build /tmp/$LibreOffice_File /tmp/$LibreOffice_File
RUN cd /tmp/$LibreOffice_File/RPMS ; yum install *.rpm -y

# lib
RUN yum install cups-libs  cairo-devel libSM fontconfig -y


# clean 
RUN  rm -rf /tmp/*

ENV PATH="$LibreOffice_Home/program:${PATH}"

CMD ["bin/bash"]