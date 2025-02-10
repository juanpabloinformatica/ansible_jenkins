FROM python:slim-bookworm
WORKDIR /code
COPY ./requirements.txt /code/requirements.txt
RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt
COPY ./main.py /code/
RUN chmod +x ./main.py
CMD python3 main.py
