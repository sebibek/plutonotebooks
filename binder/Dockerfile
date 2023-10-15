FROM jupyter/base-notebook:latest

USER root

RUN apt-get update && \
    apt-get install -y --no-install-recommends wget libc6 && \
    apt-get install -y --no-install-recommends build-essential && \
    apt-get install -y --no-install-recommends ffmpeg && \
    apt-get clean && rm -rf /var/lib/apt/lists/* 

#    apt-get install -y --no-install-recommends npm nodejs && \

USER ${NB_USER}

RUN pip install --no-cache --upgrade pip && \
    pip install --no-cache jupyter-server 

COPY --chown=${NB_USER}:users ./plutoserver ./plutoserver
COPY --chown=${NB_USER}:users ./environment.yml ./environment.yml
COPY --chown=${NB_USER}:users ./setup.py ./setup.py
COPY --chown=${NB_USER}:users ./runpluto.sh ./runpluto.sh
COPY --chown=${NB_USER}:users ./Project.toml ./Project.toml
COPY --chown=${NB_USER}:users ./Manifest.toml ./Manifest.toml
# COPY --chown=${NB_USER}:users ./create_sysimage.jl ./create_sysimage.jl

RUN jupyter lab build --dev-build=False --minimize=False && \
    jupyter lab clean && \
    pip install . --no-cache-dir && \
    rm -rf ~/.cache

USER root

RUN wget https://julialang-s3.julialang.org/bin/linux/x64/1.9/julia-1.9.3-linux-x86_64.tar.gz && \
    tar -xvzf julia-1.9.3-linux-x86_64.tar.gz && \
    mv julia-1.9.3 /opt/ && \
    ln -s /opt/julia-1.9.3/bin/julia /usr/local/bin/julia && \
    rm julia-1.9.3-linux-x86_64.tar.gz

USER ${NB_USER}

ENV USER_HOME_DIR /home/${NB_USER}
ENV JULIA_PROJECT ${USER_HOME_DIR}
ENV JULIA_DEPOT_PATH ${USER_HOME_DIR}/.julia
WORKDIR ${USER_HOME_DIR}

RUN julia --project=${USER_HOME_DIR} -e "import Pkg; Pkg.Registry.update(); Pkg.instantiate(); Pkg.precompile()"

RUN julia --project=${USER_HOME_DIR} create_sysimage.jl
RUN julia -J${USER_HOME_DIR}/sysimage.so --project=${USER_HOME_DIR} -e "import Pkg; Pkg.precompile()"
RUN julia --project=${USER_HOME_DIR} -e "import Pkg; Pkg.precompile()"