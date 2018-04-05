FROM ubuntu:16.04
MAINTAINER Eric Lau <eric.lau@homelight.com>

RUN export LANG=C.UTF-8 &&\
    apt-get clean &&\
    apt-get update &&\
    apt-get autoclean -y &&\
    apt-get autoremove -y &&\
    apt-get update &&\
# install utilities
    apt-get install -f -y apt-utils &&\
# Install the Linux Libertine font http://www.linuxlibertine.org/
    apt-get install -f -y fonts-linuxlibertine &&\
# install TeX Live and ghostscript
    apt-get install -f -y ghostscript=9.18* \
                          make=4.1* \
                          wget \
                          texlive-full=2015.2016* \
                          texlive-fonts-extra=2015.2016* \
                          texlive-fonts-recommended=2015.2016* \
                          texlive-math-extra=2015.2016* \
                          texlive-luatex=2015.2016* \
                          texlive-pstricks=2015.2016* \
                          texlive-science=2015.2016* \
                          texlive-xetex=2015.2016* &&\
# free huge amount of unused space
    apt-get purge -f -y make-doc \
                        texlive-fonts-extra-doc \
                        texlive-fonts-recommended-doc \
                        texlive-humanities-doc \
                        texlive-latex-base-doc \
                        texlive-latex-extra-doc \
                        texlive-latex-recommended-doc \
                        texlive-metapost-doc \
                        texlive-pictures-doc \
                        texlive-pstricks-doc \
                        texlive-science-doc

# Install Microsoft's TrueType core fonts
RUN echo deb http://archive.ubuntu.com/ubuntu/ xenial multiverse | tee --append /etc/apt/sources.list && apt -y update \
  && echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections \
  && apt -y install ttf-mscorefonts-installer

# Install the PT Sans Narrow font
RUN tmp_dir=$(mktemp -d) \
  && wget --no-check-certificate https://fonts.google.com/download?family=PT%20Sans%20Narrow -O $tmp_dir/pt_sans_narrow.zip \
  && unzip $tmp_dir/pt_sans_narrow.zip -d $tmp_dir \
  && mkdir -p /usr/share/fonts/truetype/pt_sans_narrow \
  && cp $tmp_dir/*.ttf /usr/share/fonts/truetype/pt_sans_narrow \
  && rm -rf $tmp_dir

# Install Adobe fonts
RUN mkdir -p /usr/share/fonts/opentype/adobe \
  && path_prefix="/usr/share/fonts/opentype/adobe" \
  && url_prefix="https://cs.fit.edu/code/projects/ndworld/repository/revisions/11/raw/Resources/Fonts" \
  && wget --no-check-certificate $url_prefix/AdobeFangsongStd-Regular.otf -P $path_prefix \
  && wget --no-check-certificate $url_prefix/AdobeHeitiStd-Regular.otf -P $path_prefix \
  && wget --no-check-certificate $url_prefix/AdobeKaitiStd-Regular.otf -P $path_prefix \
  && wget --no-check-certificate $url_prefix/AdobeSongStd-Light.otf -P $path_prefix


# ensure that external fonts and doc folders exists
RUN mkdir /usr/share/fonts/external/ &&\
    mkdir /doc/ &&\
# Rebuild font cache
    apt -y install fontconfig && fc-cache -fv &&\
# clean up all temporary files
    apt-get clean &&\
    apt-get autoclean -y &&\
    apt-get autoremove -y &&\
    apt-get clean &&\
    rm -rf /tmp/* /var/tmp/* &&\
    rm -rf /var/lib/apt/lists/* &&\
    rm -f /etc/ssh/ssh_host_*

#RUN apt -y update && apt -y dist-upgrade && apt -y install wget apt-transport-https

#RUN apt -y install texlive-full

# RUN apt-get autoremove \
#  && apt-get clean \
#  && rm -rf /var/lib/apt/lists/*
