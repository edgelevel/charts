#!/bin/bash

# unofficial bash strict mode
set -euo pipefail
IFS=$'\n\t'

# run from any directory (no symlink allowed)
CURRENT_PATH=$(cd "$(dirname "${BASH_SOURCE[0]}")"; pwd -P)
cd ${CURRENT_PATH}

##############################

CHART_NAME=${1:?"Usage: $(basename -- $0) <CHART_NAME>"}
TMP_REPOSITORY="tmp-gh-pages"

git clone -b gh-pages git@github.com:edgelevel/helm-charts.git ${TMP_REPOSITORY}
cd ${TMP_REPOSITORY}
helm lint ../${CHART_NAME}
helm package ../${CHART_NAME}
helm repo index .
git add .
git commit -m "release ${CHART_NAME}"
git push origin gh-pages
cd ..
rm -fr ${TMP_REPOSITORY}
