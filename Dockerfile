FROM centos:8 as build
MAINTAINER lianshufeng <251708339@qq.com>
ARG LibreOffice_URL="https://www.libreoffice.org/donate/dl/rpm-x86_64/7.2.3/zh-CN/LibreOffice_7.2.3_Linux_x86-64_rpm.tar.gz"
ARG LibreOffice_File="LibreOffice_7.2.3.2_Linux_x86-64_rpm"


# download
RUN curl $LibreOffice_URL -o /tmp/LibreOffice_rpm.tar.gz
RUN cd /tmp/ ; tar xvzf LibreOffice_rpm.tar.gz 


FROM centos:8 as runtime
ARG LibreOffice_File="LibreOffice_7.2.3.2_Linux_x86-64_rpm"
ARG LibreOffice_Home="/opt/libreoffice7.2"

ARG ImageMagick_Version="7.1.0-16.x86_64"

# setup
COPY --from=build /tmp/$LibreOffice_File /tmp/$LibreOffice_File
RUN cd /tmp/$LibreOffice_File/RPMS ; yum install *.rpm -y

# lib
RUN yum install cups-libs  cairo-devel libSM fontconfig fontconfig langpacks-zh_CN -y

# env
ENV PATH="$LibreOffice_Home/program:${PATH}"


# ImageMagick
RUN yum update -y ; yum install -y libjpeg libjpeg-devel libpng libpng-devel libtiff libtiff-devel  freetype zlib
RUN dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm -y
RUN dnf install dnf-plugins-core -y ; dnf config-manager --set-enabled powertools ; dnf install ImageMagick ImageMagick-devel ImageMagick-perl -y 



# clean 
RUN  rm -rf /tmp/*

CMD ["bin/bash"]