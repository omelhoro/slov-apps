FROM google/dart-runtime

RUN pub get

RUN pub build

EXPOSE 5000
