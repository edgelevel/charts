#!/bin/bash

# unofficial bash strict mode
set -euo pipefail
IFS=$'\n\t'

# run from any directory (no symlink allowed)
CURRENT_PATH=$(cd "$(dirname "${BASH_SOURCE[0]}")"; pwd -P)
cd ${CURRENT_PATH}

##############################

CHART_NAME=${1:?"Missing CHART_NAME"}

ROOT_PATH="${CURRENT_PATH}/.."
CHART_PATH="${ROOT_PATH}/${CHART_NAME}"
TMP_REPOSITORY="${ROOT_PATH}/tmp-gh-pages"

[[ -d "${CHART_PATH}" ]] || (echo "Invalid chart: ${CHART_NAME}" && exit 1)

git clone -b gh-pages git@github.com:edgelevel/helm-charts.git ${TMP_REPOSITORY}

cd ${TMP_REPOSITORY}
helm lint ${CHART_PATH}
helm package ${CHART_PATH}
helm repo index .
git add .
git commit -m "release ${CHART_NAME}"
git push origin gh-pages
cd ${ROOT_PATH}
rm -fr ${TMP_REPOSITORY}
