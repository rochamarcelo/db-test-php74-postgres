FROM webdevops/php:7.4

# Fix debconf warnings upon build
ARG DEBIAN_FRONTEND=noninteractive

RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && \
    sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt bionic-pgdg main" > /etc/apt/sources.list.d/pgdg.list' && \
    apt update && \
	apt install -y libgmp-dev tar postgresql-client-12 && \
	docker-php-ext-install gmp && composer self-update --2

WORKDIR /
EXPOSE 9000
ENTRYPOINT ["/entrypoint"]
CMD ["supervisord"]
