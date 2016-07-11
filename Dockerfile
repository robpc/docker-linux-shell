FROM debian:jessie

RUN apt-get update -y && \
    apt-get install -y \
        vim git curl screen python python-pip groff

RUN pip install awscli 

RUN curl -o /usr/local/bin/ecs-cli https://s3.amazonaws.com/amazon-ecs-cli/ecs-cli-linux-amd64-latest
RUN chmod ugo+x /usr/local/bin/ecs-cli

RUN git clone https://github.com/robpc/bash-files.git /root/.bash-files
RUN echo "source ~/.bash-files/bashrc" >> /root/.bashrc

RUN git clone https://github.com/magicmonty/bash-git-prompt.git /root/.bash-git-prompt
RUN echo "source ~/.bash-git-prompt/gitprompt.sh" >> /root/.bashrc
RUN ln -s /root/.bash-files/git-prompt-colors.sh /root/.git-prompt-colors.sh

RUN ln -s /root/.bash-files/screenrc /root/.screenrc

RUN mkdir -p /home/host

COPY bin /root/bin
RUN chmod go-w /root/bin
RUN echo "PATH=${HOME}/bin:${PATH}" >> /root/.bashrc

VOLUME /home/host
VOLUME /cwd

WORKDIR /cwd

ENTRYPOINT /bin/bash -c "/root/bin/init-docker; bash"