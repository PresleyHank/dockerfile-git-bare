FROM ubuntu:18.04
MAINTAINER edk24

# 使用阿里云源
COPY --chown=root:root ./conf/sources.list /etc/apt/sources.list

RUN apt-get update --fix-missing && \
    apt-get install -y openssh-server git --fix-missing && \
    groupadd git && \
    useradd -g git git && \
    mkdir /home/git && \
    mkdir /home/git/.ssh && \
    git init --bare /home/git/dev.git && \
    touch /home/git/dev.git/hooks/post-receive && \
    echo "#!/bin/bash">>/home/git/dev.git/hooks/post-receive && \
    echo "git --work-tree=/app checkout -f">>/home/git/dev.git/hooks/post-receive && \
    chmod +x /home/git/dev.git/hooks/post-receive && \
    mkdir /app && \
    chown -R git:git /app && \
    chown -R git:git /home/git && \
    chmod -R 755 /home/git && \
    echo "#!/bin/bash">>/start_ssh.sh && \
    echo "service ssh start">>/start_ssh.sh && \
    chmod +x /start_ssh.sh
    # fuck 755权限才认

COPY --chown=git:git ./conf/authorized_keys /home/git/.ssh/authorized_keys

VOLUME ["/app"]
WORKDIR /
EXPOSE 22
CMD ssh start