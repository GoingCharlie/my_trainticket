FROM python:3

RUN /bin/cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' >/etc/timezone
ADD https://github.com/open-telemetry/opentelemetry-java-instrumentation/releases/latest/download/opentelemetry-javaagent.jar /usr/local/opentelemetry-javaagent.jar
RUN chmod 644 /usr/local/opentelemetry-javaagent.jar
ENV JAVA_TOOL_OPTIONS="-javaagent:/usr/local/opentelemetry-javaagent.jar" \
    OTEL_TRACES_EXPORTER=jaeger \
    OTEL_EXPORTER_JAEGER_ENDPOINT=http://172.26.146.180:14250 \
    OTEL_EXPORTER_JAEGER_TIMEOUT=100000 \
    OTEL_METRICS_EXPORTER=prometheus \
    OTEL_LOGS_EXPORTER=logging
RUN apt update -y
RUN apt install -y cmake
RUN apt install -y libgl1-mesa-glx

ENV PYTHONUNBUFFERED=TRUE

RUN mkdir -p /app
ADD . /app/
WORKDIR /app

RUN pip install -r requirements.txt

CMD ["gunicorn", "-w", "4", "-b", "0.0.0.0:17001", "app:app"]

EXPOSE 17001