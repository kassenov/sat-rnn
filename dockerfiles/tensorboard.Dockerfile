# Use small image with Python pre-installed.
FROM python:3.9.1-slim-buster
# Install tensorboard
RUN pip3 install tensorboard