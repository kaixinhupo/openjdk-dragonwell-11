FROM centos:centos7

WORKDIR /tmp

RUN yum install -y wget && echo "Downloading jdk" \ 
    && wget https://dragonwell.oss-cn-shanghai.aliyuncs.com/11/11.0.7.2_GA/linux/x64/Alibaba_Dragonwell_11.0.7.2%2B9_Linux_x64.tar.gz \
    -q -O /tmp/Alibaba_Dragonwell_11.0.7.2+9_Linux_x64.tar.gz \
    && mv ./Alibaba_Dragonwell_11.0.7.2+9_Linux_x64.tar.gz /tmp/dragonwell.tar.gz

#COPY ./Alibaba_Dragonwell_11.0.7.2+9_Linux_x64.tar.gz /tmp/dragonwell.tar.gz

RUN mkdir /usr/local/dragonwell11 \
    && tar -xzvf dragonwell.tar.gz -C /usr/local/dragonwell11/ \
    && mv /usr/local/dragonwell11/dragonwell_11.0.7.2/* /usr/local/dragonwell11/ \
    && rm -rf /usr/local/dragonwell11/dragonwell_11.0.7.2/ \
    && rm /tmp/dragonwell.tar.gz

ENV JAVA_HOME /usr/local/dragonwell11
ENV PATH $JAVA_HOME/bin:$PATH

ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
ENV LC_ALL "zh_CN.UTF-8"

CMD ["/bin/bash"]