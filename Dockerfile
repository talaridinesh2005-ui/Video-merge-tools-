FROM python:3.9

ENV DEBIAN_FRONTEND=noninteractive

# System deps + TIME SYNC (FIXED)
RUN apt -qq update && apt -qq install -y \
    ffmpeg wget unzip p7zip-full curl busybox aria2 \
    tzdata ntpsec-ntpdate \
    && ntpsec-ntpdate time.google.com || true

# App
COPY . /app
WORKDIR /app
RUN chmod 777 /app

# Rclone
RUN wget https://rclone.org/install.sh
RUN chmod 777 ./install.sh
RUN bash install.sh

# Python deps
RUN pip3 install --no-cache-dir -r requirements.txt

ENV PORT=8000
EXPOSE 8000

CMD sh start.sh
