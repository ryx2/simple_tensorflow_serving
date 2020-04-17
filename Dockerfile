FROM python:3.6

RUN apt-get update -y
RUN apt-get install -y unzip wget
RUN apt-get install -y default-jdk

RUN wget http://h2o-release.s3.amazonaws.com/h2o/rel-wolpert/8/h2o-3.18.0.8.zip
RUN unzip ./h2o-3.18.0.8.zip
RUN mv h2o-3.18.0.8/h2o.jar /tmp/

ADD ./requirements.txt /
RUN pip3 install -r /requirements.txt

ADD . /simple_tensorflow_serving/
WORKDIR /simple_tensorflow_serving/
RUN cp ./third_party/openscoring/openscoring-server-executable-1.4-SNAPSHOT.jar /tmp/

RUN python ./setup.py install

# Modify the CMD to include the path to our USE model and a shared sentencepiece library.
# We also hardcode the serving port here, but you can tweak it to your convenience

CMD ["simple_tensorflow_serving", "--model_base_path=/home/raymond/pyden/src/pyden/simple_tensorflow_serving/models/use/00000001", "--custom_op_paths=/home/raymond/pyden/src/pyden/simple_tensorflow_serving/tf_sentencepiece/"]

