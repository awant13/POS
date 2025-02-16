FROM heywoodlh/systemd:debian

COPY ./build/unibox-ve/unibox /opt/unibox

# Добавляем архивные репозитории и отключаем проверки даты (т.к. старый релиз)
RUN echo 'deb http://archive.debian.org/debian stretch main contrib non-free' > /etc/apt/sources.list \
    && echo 'Acquire::Check-Valid-Until "false";' > /etc/apt/apt.conf.d/99no-check-valid-until \
    && apt-get update \
    && apt-get install -y --no-install-recommends sudo curl bash python2.7 python-pip ca-certificates && update-ca-certificates \
    && pip2 install --upgrade pip \ 
    && pip2 install --no-cache-dir -r /opt/unibox/requirements.txt \
    && chmod +x /opt/unibox/unibox-bin /opt/unibox/check/healthcheck.sh \
    && cp /opt/unibox/unibox.service /etc/systemd/system \ 
    && systemctl enable unibox \ 
    && rm -f /opt/unibox/unibox.service /opt/unibox/requirements.txt \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Проверка состояния контейнера
HEALTHCHECK --interval=30s --retries=5 --start-period=180s --timeout=50s CMD /opt/unibox/check/healthcheck.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/bin/bash"]