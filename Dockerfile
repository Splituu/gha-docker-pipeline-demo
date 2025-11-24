FROM python:3.14-alpine

WORKDIR /usr/local/app

COPY requirements.txt ./

RUN pip install --no-cache-dir -r requirements.txt

COPY src ./src
COPY tests ./tests

ENV COUNTRY=Poland

CMD ["python3", "src/main.py"]