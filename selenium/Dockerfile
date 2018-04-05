FROM selenium/standalone-chrome

USER root
RUN wget https://bootstrap.pypa.io/get-pip.py
RUN python3 get-pip.py
RUN python3 -m pip install selenium unicodecsv py3-progressbar
#RUN x11vnc -storepasswd mysecret /home/seluser/.vnc/passwd