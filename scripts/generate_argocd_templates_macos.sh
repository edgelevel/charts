#!/bin/bash

# unofficial bash strict mode
set -euo pipefail
IFS=$'\n\t'

# run from any directory (no symlink allowed)
CURRENT_PATH=$(cd "$(dirname "${BASH_SOURCE[0]}")"; pwd -P)
cd ${CURRENT_PATH}

##############################

[[ "$(uname)" == "Darwin" ]] || (echo "Only macOS supported" && exit 1)

ROOT_PATH="${CURRENT_PATH}/.."
CHART_PATH="${ROOT_PATH}/argocd"
TEMPLATES_PATH="${CHART_PATH}/templates/"

PREFIX="argo-cd-"
INSTALL_FILE="install.yaml"

# reset templates
rm -fr ${TEMPLATES_PATH}
mkdir -p ${TEMPLATES_PATH}
cd ${TEMPLATES_PATH}

# https://argoproj.github.io/argo-cd/getting_started/#1-install-argo-cd
curl -s -o ${INSTALL_FILE} https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/${INSTALL_FILE}

# split by resource type
split -p "---" -a 3 ${INSTALL_FILE} ${PREFIX}

function extract_file_name {
  local FILE=$1
  # extract second column from lines starting with "kind"
  # prefix upper case with dash
  # convert upper to lower case
  # add file extension
  awk '/^kind/ { print $2 }' $FILE |
    sed 's/\(.\)\([A-Z]\)/\1-\2/g' |
    tr '[:upper:]' '[:lower:]' |
    awk '{ print $1".yaml" }'
}

# append content to file of the same resource type
for FILE in ${PREFIX}*; do
  FILE_NAME=$(extract_file_name $FILE)
  cat $FILE >> $FILE_NAME
done

# remove comment
find . -type f -name '*.yaml' -exec sed -i '.orig' 's/^.*DO NOT EDIT$/---/' {} \;

# cleanup
rm ${INSTALL_FILE}
rm ${PREFIX}*
rm *".orig"
