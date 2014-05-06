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

###################################################################
## Application prereqs
###################################################################
ADD ./todolist /src
ADD ./docker/run.sh /src/run.sh
RUN apt-get install -y make
ENV PATH $PATH:/opt/play
RUN make -C /src

EXPOSE 9000
CMD /src/run.sh

