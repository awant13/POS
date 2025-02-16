# Unibox

POSBOX w/o Odoo

## Getting started

Unibox project provide Odoo-10 users with modern posbox without Odoo-8.

## Project files

Unibox consists of the following files under unibox directory:

**cert.pem**            - cert file

**key.pem**             - cert file

**README.md**           - this guide (not required for run)

**requirements.txt**    - dependencies for python virtual environment, (not required for run)

**storage.conf**        - storage configuration file

**unibox.service**      - service description for systemd, (not required for run)

**unibox-bin**          - main executable

**unibox_*.zip**        - project library bundle (version dependent)

**каталог для log файлов**
пустой

**каталог для хранения данных**
с подкаталогом config и файлами
**fr.conf**          - файл конфигурации фискального регистратора
**unibox.conf**      - основной файл конфигурации

## Linux system setup

### Setup as root

Create user uni and update your system:

useradd -m uni

usermod -a -G sudo uni

usermod -a -G dialout uni

passwd uni

apt update

apt upgrade

apt install python2 virtualenv mc

### Setup under uni

Copy project dir unibox under uni home and then setup virtual environment:

mkdir ve

cd ve

virtualenv --python=$(which python2) unibox

source ~/ve/unibox/bin/activate

pip install --upgrade pip

pip install -r ~/unibox/requirements.txt

### Setup unibox device

edit unibox configuration file (described later)

get unibox serial number with call:

~/ve/unibox/bin/python unibox-bin --serial

set this serial to Odoo pos before connection

### Setup systemd service

copy unibox.service into /etc/systemd/system folder

use systemd commands for start,stop,activate and status as follows:

sudo systemctl status unibox

## Unibox configuration file

### Main section

Секция предназначена для выбора режима работы юнибокса

**driver**: выбор драйвера фискального регистратора (shtrih или virtualfr)

**link**: выбор драйвера связи (uplink или linkmq)

**serial**: если присуствует - меняет серийный номер устройства на указанный

### Options section

In options secton we can setup logging:

**loglevel**: info or debug

**logfile** may be in absolute or relative path
target dir for log create automatically, intermediate you must create manually

**logrotate** provide rotating strategy: time or size

**logsize** limit individual log file size for size mode

**logcnt** limit log files count for both rotation mode

**logwhen** provide different time based rotating modes as in [Python 2.7 Docs
](https://docs.python.org/2.7/library/logging.handlers.html#logging.handlers.TimedRotatingFileHandler)

**loginterval** provide time interval for time mode

### PWI section

**port** on which unibox web interface work

### Uplink section

only 2 position may be changed:

**odoo_adr** - full address of odoo instance for uplink with protocol and port

**odoo_db** - database name of odoo instance

### Storage section

**area** - path name for unibox data

**mountable**: True or False

type of data handling strategy - if mountable is True then area must
be mountable partition, unibox will be mount it only for activity periods

## Optional certificate regeneration

openssl req -newkey rsa:4096 \
    -x509 \
    -sha256 \
    -days 3650 \
    -nodes \
    -out cert.pem \
    -keyout key.pem \
    -subj "/C=RU/ST=63/L=Syzran/O=Greenvector LTD/OU=IT/CN=greenvector.ru"

