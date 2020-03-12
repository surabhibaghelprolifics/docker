# We will use Ubuntu for our image
FROM ubuntu:latest

# Updating Ubuntu packages
RUN apt-get update && apt-get -y update

# System packages 
RUN apt-get update && apt-get install -y curl

#installing python
RUN apt-get install -y build-essential python3.6 python3-pip python3-dev

#create main directory
RUN mkdir src
WORKDIR src/
COPY . .

#install libraries
RUN pip3 install jupyter

RUN pip3 install numpy
RUN pip3 install pandas
RUN pip3 install matplotlib
RUN pip3 install scikit-learn 
RUN pip3 install seaborn 

# Configuring access to Jupyter
RUN mkdir /opt/notebooks
RUN jupyter notebook --generate-config --allow-root
RUN echo "c.NotebookApp.password = u'sha1:6a3f528eec40:6e896b6e4828f525a6e20e5411cd1c8075d68619'" >> /root/.jupyter/jupyter_notebook_config.py

# Jupyter listens port: 8888
EXPOSE 8888

# Run Jupytewr notebook as Docker main process
CMD ["jupyter", "notebook", "--allow-root", "--notebook-dir=/opt/notebooks", "--ip='*'", "--port=8888", "--no-browser"]
