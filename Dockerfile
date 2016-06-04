FROM google/dart-runtime

RUN pub build

EXPOSE 5000
