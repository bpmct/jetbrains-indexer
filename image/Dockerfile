FROM openkbs/jdk-mvn-py3

# Shared indexing works best
# when you use the proper IDE
# for the language you are using
ENV IDE=ideaIU
ENV IDE_SHORT=idea
ENV IDE_CODE=idea
ENV IDE_VERSION=2021.3

ARG IDE_TAR=${IDE}-${IDE_VERSION}.tar.gz
ARG CDN_LAYOUT_TOOL_VERSION=0.8.65

# Runtime variables
ENV INDEXES_CDN_URL=http://localhost:3000/project
ENV COMMIT_ID=''
ENV PROJECT_ID=''
ENV IDEA_PROJECT_DIR="/var/project"
ENV SHARED_INDEX_BASE="/shared-index"

USER root
WORKDIR /opt

# Set up folders
RUN mkdir -p /etc/idea && \
    mkdir -p /etc/idea/config && \
    mkdir -p /etc/idea/log && \
    mkdir -p /etc/idea/system && \
    mkdir ${SHARED_INDEX_BASE} && \
    mkdir ${SHARED_INDEX_BASE}/output && \
    mkdir ${SHARED_INDEX_BASE}/temp

# Install IntelliJ IDEA Ultimate
RUN wget -nv https://download-cf.jetbrains.com/${IDE_CODE}/${IDE_TAR} && \
    tar xzf ${IDE_TAR} && \
    tar tzf ${IDE_TAR} | head -1 | sed -e 's/\/.*//' | xargs -I{} ln -s {} idea && \
    rm ${IDE_TAR} && \
    echo idea.config.path=/etc/idea/config >> /opt/idea/bin/idea.properties && \
    echo idea.log.path=/etc/idea/log >> /opt/idea/bin/idea.properties && \
    echo idea.system.path=/etc/idea/system >> /opt/idea/bin/idea.properties && \
    chmod -R 777 /opt/idea && \
    chmod -R 777 ${SHARED_INDEX_BASE} && \
    chmod -R 777 /etc/idea

# Install cdn-layout-tool
RUN wget https://packages.jetbrains.team/maven/p/ij/intellij-shared-indexes-public/com/jetbrains/intellij/indexing/shared/cdn-layout-tool/${CDN_LAYOUT_TOOL_VERSION}/cdn-layout-tool-${CDN_LAYOUT_TOOL_VERSION}.zip -O cdn-layout-tool.zip && \
    unzip cdn-layout-tool.zip && \
    rm cdn-layout-tool.zip && \
    mv cdn-layout-tool-${CDN_LAYOUT_TOOL_VERSION} cdn-layout-tool


COPY entrypoint.sh entrypoint.sh
CMD ./entrypoint.sh

# Comment out the CMD line and uncomment the following for testing
# ENTRYPOINT ["tail", "-f", "/dev/null"]
