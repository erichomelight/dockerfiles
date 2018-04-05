# ezml-tensorflow-notebook
FROM jupyter/tensorflow-notebook
#:0591e0253a6e

# USER root

# RUN apt-get update && \
# 		apt-get install -y curl && \
# 		curl --silent --location https://deb.nodesource.com/setup_0.12 | sudo bash - && \
# 		apt-get install --yes nodejs npm && \
# 		ln -s /usr/bin/nodejs /usr/bin/node && \
# 		npm install -g bower

# Do the pip installs as the unprivileged notebook user
USER jovyan

# Install dashboard layout and preview within Jupyter Notebook
# RUN pip install jupyter_dashboards && \
# 	jupyter contrib dashboards install --user --symlink && \
# 	jupyter contrib dashboards activate

# # Install declarative widgets for Jupyter Notebook
# RUN pip install jupyter_declarativewidgets && \
# 	jupyter contrib declarativewidgets install --user --symlink && \
# 	jupyter contrib declarativewidgets activate

# # Install content management to support dashboard bundler options
# RUN pip install jupyter_cms && \
# 	jupyter contrib cms install --user --symlink && \
# 	jupyter contrib cms activate
# RUN pip install jupyter_dashboards_bundlers && \
#     jupyter dashboards_bundlers activate

RUN conda install -y gcc
RUN pip install xgboost
RUN pip install usaddress
RUN pip install folium
RUN pip install gmplot
RUN pip install 'psycopg2==2.7.3.1'
RUN pip install 'squarify==0.3.0'
RUN pip install datarobot datarobot-batch-scoring
RUN pip install jupyter_contrib_nbextensions && \
    jupyter contrib nbextension install --user
    #--symlink && \
    #jupyter contrib nbextension activate

WORKDIR /home/jovyan
COPY notebook.json .jupyter/nbconfig/notebook.json
COPY drconfig.yaml .config/datarobot/drconfig.yaml
#WORKDIR /go/src/project/
