FROM ubuntu

ARG FLUENTD_VERSION

RUN apt-get update -y && apt-get install -y \
              build-essential \
              curl \      
              libffi-dev \
              systemd \
              ruby \
              ruby-dev \
              git \
              postgresql-client \
              libpq5 \
              libpq-dev \
        && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/fluent/
RUN gem install specific_install
RUN gem install fluentd -v ${FLUENTD_VERSION}
RUN gem install pg -v '0.17.0'
RUN gem specific_install https://github.com/fluent/fluent-plugin-sql.git

COPY fluent.conf /etc/fluent/
COPY docker-entrypoint.sh /

WORKDIR /etc/fluent

EXPOSE 24224

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD [ "fluentd", "-c", "fluent.conf" ]
