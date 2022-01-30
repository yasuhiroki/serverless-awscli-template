#!/bin/bash
# original: https://github.com/aws/aws-cdk/blob/802a031245619715fb405d04a02056cf699e0fc2/packages/@aws-cdk/lambda-layer-awscli/layer/build.sh
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

