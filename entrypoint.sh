#!/bin/sh -l

echo "========================"
echo "= Publish OPA Policies ="
echo "========================"

# Registry credentials will be stored here
AUTH_FILE_DIR="$HOME/.docker"
mkdir -p $AUTH_FILE_DIR
AUTH_FILE="$AUTH_FILE_DIR/config.json"

# Registry credentials content JSON structure
JSON_FMT='{"auths": {"%s": {"auth": "%s"}}}'

if [ -z "$INPUT_REGISTRY" ]; then
    echo "ERROR - REGISTRY not provided"
    exit 1
fi

if [ ! -z "$REGISTRY_USER" -a ! -z "$REGISTRY_PWD" ]; then
    printf "$JSON_FMT" "$INPUT_REGISTRY" "$(echo "$REGISTRY_USER:$REGISTRY_PWD" | base64 -w 0)" > $AUTH_FILE
fi

echo conftest verify -p $INPUT_PATH
conftest verify -p $INPUT_PATH || exit 1

echo conftest push $INPUT_REGISTRY/$INPUT_BUNDLE_NAME:$INPUT_TAG -p $INPUT_PATH
conftest push $INPUT_REGISTRY/$INPUT_BUNDLE_NAME:$INPUT_TAG -p $INPUT_PATH || exit 1

if [ "$INPUT_TAG_LATEST" == "true" ]; then
    echo conftest push $INPUT_REGISTRY/$INPUT_BUNDLE_NAME:latest -p $INPUT_PATH
    conftest push $INPUT_REGISTRY/$INPUT_BUNDLE_NAME:latest -p $INPUT_PATH || exit 1
fi
