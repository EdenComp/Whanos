FROM python:3.12

SHELL ["/bin/bash", "-c"]

WORKDIR /ansible

RUN pip install --upgrade pip
RUN pip install ansible
RUN curl https://pyenv.run | bash

RUN git clone https://github.com/kubernetes-incubator/kubespray.git
RUN pip install -r kubespray/requirements.txt

ENTRYPOINT ["/bin/bash"]
