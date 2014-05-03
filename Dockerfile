FROM lukasz/docker-scala

###################################################################
## Play install
###################################################################
RUN curl http://downloads.typesafe.com/play/2.2.3/play-2.2.3.zip > /tmp/play-2.2.3.zip
RUN apt-get install -y unzip
RUN cd /opt && unzip /tmp/play-2.2.3.zip
RUN ln -s /opt/play-2.2.3 /opt/play
RUN chmod a+x /opt/play/play
RUN chmod a+x /opt/play/framework/build
ENV HOME /root/
RUN echo "export PATH=$PATH:/opt/play" >> ~/.bashrc
RUN /opt/play/play help


###################################################################
## Application prereqs
###################################################################
EXPOSE 9000
ADD ./todolist /src
RUN cd /src && /opt/play/play compile

CMD cd /src && /opt/play/play -DapplyEvolutions.default=true start

