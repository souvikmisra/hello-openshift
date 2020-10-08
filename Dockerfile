FROM openvino/ubuntu18_dev
USER root
RUN apt-get update && apt-get install -y git python3-pip

COPY app.py /opt/
RUN mkdir -p /opt/templates
COPY templates/index.html /opt/templates/

WORKDIR /opt/
RUN git clone https://github.com/intel-iot-devkit/brain-tumor-segmentations.git

RUN pip3 install flask matplotlib tk numpy h5py

RUN mkdir -p /opt/static && chmod 777 /opt/static

WORKDIR /opt/intel/openvino/deployment_tools/model_optimizer/
RUN python3 mo_tf.py --input_model /opt/brain-tumor-segmentations/resources/saved_model_frozen.pb  --output_dir /opt/brain-tumor-segmentations/resources/output/IR_models/FP32/ --input_shape=[1,144,144,4] --data_type FP32 --model_name saved_model
RUN python3 mo_tf.py --input_model /opt/brain-tumor-segmentations/resources/saved_model_frozen.pb  --output_dir /opt/brain-tumor-segmentations/resources/output/IR_models/FP16/ --input_shape=[1,144,144,4] --data_type FP16 --model_name saved_model

ENTRYPOINT FLASK_APP=/opt/app.py flask run --host=0.0.0.0 --port=8080
