FROM swiftdocker/swift

RUN apt-get update; \
    apt-get install -y software-properties-common build-essential

# Add Jazzy for documentaton
RUN apt-add-repository ppa:brightbox/ruby-ng; \
    apt-get update; \
    apt-get install -y --allow-unauthenticated libgmp3-dev libsqlite3-dev ruby2.4 ruby2.4-dev; \
    gem install rake; \
    gem install jazzy

# Build SourceKitten
RUN git clone https://github.com/jpsim/SourceKitten.git; \
    cd SourceKitten; \
    swift build -c release; \
    cp ./.build/release/sourcekitten /usr/local/bin/sourcekitten; \
    cp ./.build/release/libCYaml.so /usr/local/lib/libCYaml.so; \
    rm -rf SourceKitten
COPY ./libsourcekitdInProc.so /usr/local/lib/libsourcekitdInProc.so

