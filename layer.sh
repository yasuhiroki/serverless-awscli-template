#!/bin/bash
# original: https://github.com/aws-samples/aws-lambda-layer-awscli/blob/5f30f9c96f4a3d837a1ebdcec0db15c07b5c7fd5/src/custom-layer/build.sh
set -euo pipefail

cd $(dirname $0)

echo ">> Building AWS Lambda layer inside a docker image..."

TAG='aws-lambda-layer'

docker build -t ${TAG} .

echo ">> Extrating layer.zip from the build container..."
CONTAINER=$(docker run -d ${TAG} false)
docker cp ${CONTAINER}:/layer.zip layer.zip

echo ">> Stopping container..."
docker rm -f ${CONTAINER}

echo ">> Unzip layer.zip"
mkdir -p layer
unzip layer.zip -d layer/
rm layer.zip

