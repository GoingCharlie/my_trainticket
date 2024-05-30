FROM node

RUN /bin/cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' >/etc/timezone
ADD https://github.com/open-telemetry/opentelemetry-java-instrumentation/releases/latest/download/opentelemetry-javaagent.jar /usr/local/opentelemetry-javaagent.jar
RUN chmod 644 /usr/local/opentelemetry-javaagent.jar
ENV JAVA_TOOL_OPTIONS="-javaagent:/usr/local/opentelemetry-javaagent.jar" \
    OTEL_TRACES_EXPORTER=jaeger \
    OTEL_EXPORTER_JAEGER_ENDPOINT=http://172.26.146.180:14250 \
    OTEL_EXPORTER_JAEGER_TIMEOUT=100000 \
    OTEL_METRICS_EXPORTER=prometheus \
    OTEL_LOGS_EXPORTER=logging
RUN mkdir -p /app
WORKDIR /app

ADD ./node_modules /app/node_modules
ADD ./package.json /app/
ADD ./public /app/public
# RUN npm install

ADD ./bin /app/bin
ADD ./app.js /app/
CMD [ "npm", "start" ]

EXPOSE 16108