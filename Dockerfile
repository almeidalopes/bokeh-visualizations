FROM python:3.6-alpine

COPY . /app
WORKDIR /app

RUN apk add make automake gcc g++ subversion python3-dev
RUN apk --no-cache add python python3 \
                       build-base \
                       python-dev python3-dev \
                       # wget dependency
                       openssl \
                       # dev dependencies
                       git \
                       bash \
                       sudo \
                       py2-pip \
                       # Pillow dependencies
                       jpeg-dev \
                       zlib-dev \
                       freetype-dev \
                       lcms2-dev \
                       openjpeg-dev \
                       tiff-dev \
                       tk-dev \
                       tcl-dev \
                       harfbuzz-dev \
                       fribidi-dev


RUN pip install Pillow
RUN pip install -r requirements.txt

CMD ["bokeh", "serve", "random-plot"]
