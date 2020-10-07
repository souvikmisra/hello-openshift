FROM openvino/ubuntu18_dev
USER root
RUN apt-get update && apt-get install -y git python3-bs4 python3-pip

COPY app.py /opt/
WORKDIR /opt/
RUN git clone https://github.com/intel-iot-devkit/pneumonia-classification.git

RUN pip3 install flask matplotlib

RUN mkdir -p /opt/output && chmod 777 /opt/output

WORKDIR /opt/intel/openvino/deployment_tools/model_optimizer/
RUN python3 mo_tf.py -m /opt/pneumonia-classification/resources/model/model.pb --input_shape=[1,224,224,3] --data_type FP32 -o /opt/pneumonia-classification/resources/FP32 --mean_values [123.75,116.28,103.58] --scale_values [58.395,57.12,57.375]
RUN python3 mo_tf.py -m /opt/pneumonia-classification/resources/model/model.pb --input_shape=[1,224,224,3] --data_type FP16 -o /opt/pneumonia-classification/resources/FP16 --mean_values [123.75,116.28,103.58] --scale_values [58.395,57.12,57.375]
ENTRYPOINT FLASK_APP=/opt/app.py flask run --host=0.0.0.0 --port=8080
