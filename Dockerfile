FROM google/dart-runtime:1.8.0

RUN pub get

RUN pub build

EXPOSE 5000
