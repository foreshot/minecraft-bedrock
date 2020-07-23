FROM buildpack-deps:curl AS download
ARG MINECRAFT_VERSION
RUN apt-get update && apt-get install -y  --no-install-recommends \
    unzip \
    && apt-get clean
LABEL repository https://github.com/foreshot/minecraftbedrockedition.git
LABEL company Foreshot Development llc
LABEL game Minecraft Bedrock Edition
LABEL version ${MINECRAFT_VERSION}

ENV MINECRAFT_VERSION=${MINECRAFT_VERSION}
WORKDIR /minecraft
RUN curl https://minecraft.azureedge.net/bin-linux/bedrock-server-${MINECRAFT_VERSION}.zip -o bedrock-server.zip && \
    unzip bedrock-server.zip && \
    rm --force bedrock_server_realms.debug bedrock-server.zip


FROM ubuntu:bionic AS server
ARG MINECRAFT_VERSION
LABEL repository https://github.com/foreshot/minecraftbedrockedition.git
LABEL company Foreshot Development llc
LABEL game Minecraft Bedrock Edition
LABEL version ${MINECRAFT_VERSION}

RUN apt-get update && apt-get install -y --no-install-recommends \
    libcurl4 \
    libssl1.0.0 \
    && apt-get clean
COPY --from=download /minecraft/ /opt/minecraft/
RUN ln -s /opt/minecraft/bedrock_server /usr/local/bin/bedrock_server && \
    mkdir /var/minecraft && \
    mv /opt/minecraft/server.properties /var/minecraft/server.properties && \
    ln -s /var/minecraft/server.properties /opt/minecraft/server.properties
WORKDIR /opt/minecraft/
ENV LD_LIBRARY_PATH=/opt/minecraft/
CMD [ "bedrock_server" ]