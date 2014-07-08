# Copyright 2014 Joukou Ltd
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
FROM quay.io/joukou/base
MAINTAINER Isaac Johnston <isaac.johnston@joukou.com>

ENV NODEJS_VERSION 0.10.32
ENV CFLAGS -march=corei7 -O2
ENV CXX g++ -Wno-unused-local-typedefs
ENV CXXFLAGS -march=corei7 -O2

# Install Node.js
WORKDIR /tmp
RUN curl -O http://nodejs.org/dist/v${NODEJS_VERSION}/node-v${NODEJS_VERSION}.tar.gz && \
    tar xzvf node-v${NODEJS_VERSION}.tar.gz && \
    cd /tmp/node-v${NODEJS_VERSION} && \
    ./configure && \
    make -j"$(nproc)" && \
    make install && \
    cd /usr/local/bin && \
    strip --strip-unneeded node && \
    cd /root && \
    echo '\n# Node.js\nexport PATH="node_modules/.bin:$PATH"' >> .bash_profile && \
    rm -rf /tmp/*