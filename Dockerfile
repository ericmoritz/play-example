FROM lukasz/docker-scala

###################################################################
## Application prereqs
###################################################################
ADD ./todolist /src
RUN cd /src; sbt compile stage

EXPOSE 9000
ENTRYPOINT ["/src/target/universal/stage/bin/todolist"]
CMD ["-Dhttp.address=0.0.0.0", "-Dhttp.port=9000", "-DapplyEvolutions.default=true"]

