FROM python:3.6-jessie

RUN apt-get update
RUN apt-get install unzip

# install requirements
COPY ./requirements.txt /app/requirements.txt
RUN pip3 install -r /app/requirements.txt

# get plink
RUN wget https://www.cog-genomics.org/static/bin/plink181012/plink_linux_x86_64.zip
RUN unzip plink_linux_x86_64.zip
RUN rm plink_linux_x86_64.zip

# # get vcftools
RUN mkdir vcftools
RUN git clone https://github.com/vcftools/vcftools.git /vcftools
RUN (cd /vcftools; ./autogen.sh; ./configure; make; make install)

COPY . /app
WORKDIR /app

CMD /bin/bash
