#!/bin/sh

print_info(){
  echo "\033[32m INFO $@ \033[0m" > /dev/stderr
}
print_warning(){
  echo "\033[33m WARNING $@ \033[0m \n " > /dev/stderr
}
print_error(){
  echo "\033[31m ERROR $@ \033[0m \a \n " > /dev/stderr
  exit 1
}


echo "------------------------"
echo "--check env"
echo "----------------"

if [ ! -n "${INPUT_SOURCE_REPO}" ]; then
  INPUT_SOURCE_REPO=${GITHUB_REPOSITORY}
fi
print_info ${INPUT_SOURCE_REPO}

if [ ! -n "${INPUT_GIT_NAME}" ]; then
  INPUT_GIT_NAME=${GITHUB_ACTOR}
fi
print_info ${INPUT_GIT_NAME}

if [ ! -n "${INPUT_GIT_EMAIL}" ]; then
  INPUT_GIT_EMAIL="${GITHUB_ACTOR}@users.noreply.github.com"
fi
print_info ${INPUT_GIT_EMAIL}

if [ ! -n "${INPUT_PUBLISH_TOKEN}" ]; then
  INPUT_PUBLISH_TOKEN=${INPUT_SOURCE_TOKEN}
fi
print_info ${INPUT_PUBLISH_TOKEN}

if [ ! -n "${INPUT_PUBLISH_REPO}" ]; then
  INPUT_PUBLISH_REPO=${INPUT_SOURCE_REPO}
fi
print_info ${INPUT_PUBLISH_REPO}


export TZ=${INPUT_TIME_ZONE}


echo "------------------------"
echo "--git clone"
echo "----------------"
git clone https://${INPUT_SOURCE_TOKEN}@${INPUT_SOURCE_HUB}/${INPUT_SOURCE_REPO} -b ${INPUT_SOURCE_BRANCH} --depth=1 /source
if [ $? -eq 0 ]; then
  print_info git clone ok.
else
  print_error git clone faild.
fi


echo "------------------------"
echo "--gitbook"
echo "----------------"
gitbook init /source
gitbook install /source
gitbook build /source
if [ $? -eq 0 ]; then
  print_info gitbook build ok.
else
  print_error gitbook build faild.
fi


echo "------------------------"
echo "--git push"
echo "----------------"
mv /source/_book /publish
rm -rf /publish/.github /publish/.gitignore
cd /publish
git init
git config --local user.name ${INPUT_GIT_NAME}
git config --local user.email ${INPUT_GIT_EMAIL}
touch .nojekyll
git add .
git commit -m "gh"
git push https://${INPUT_PUBLISH_TOKEN}@${INPUT_PUBLISH_HUB}/${INPUT_PUBLISH_REPO} master:${INPUT_PUBLISH_BRANCH} --force
if [ $? -eq 0 ]; then
  print_info git push ok
else
  print_error git push faild.
fi
