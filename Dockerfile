FROM google/dart-runtime:1.16

RUN pub build

EXPOSE 5000
