FROM java:8-jre

RUN /bin/cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' >/etc/timezone
ADD https://github.com/open-telemetry/opentelemetry-java-instrumentation/releases/latest/download/opentelemetry-javaagent.jar /usr/local/opentelemetry-javaagent.jar
RUN chmod 644 /usr/local/opentelemetry-javaagent.jar
ENV JAVA_TOOL_OPTIONS="-javaagent:/usr/local/opentelemetry-javaagent.jar" \
    OTEL_TRACES_EXPORTER=jaeger \
    OTEL_EXPORTER_JAEGER_ENDPOINT=http://172.26.146.180:14250 \
    OTEL_EXPORTER_JAEGER_TIMEOUT=100000 \
    OTEL_METRICS_EXPORTER=prometheus \
    OTEL_LOGS_EXPORTER=logging
ADD ./target/ts-wait-order-service-1.0.jar /app/
CMD ["java", "-Xmx200m",  "-jar", "/app/ts-wait-order-service-1.0.jar"]

EXPOSE 15678