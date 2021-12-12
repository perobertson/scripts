#!/busybox/sh
set -xeu

OS="${1:?OS is required as first arg}"
OS_VERSION="${2:?OS is required as second arg}"

if [ -n "${CI:-}" ]; then
    mkdir -p /kaniko/.docker
    tee /kaniko/.docker/config.json <<-JSON
{
    "auths": {
        "$CI_REGISTRY": {
            "username":"$CI_REGISTRY_USER",
            "password":"$CI_REGISTRY_PASSWORD"
        }
    }
}
JSON
    /kaniko/executor \
        --build-arg="OS_VERSION=${OS_VERSION}" \
        --cache \
        --cache-repo="${CI_REGISTRY_IMAGE}/cache" \
        --cleanup \
        --context="${CI_PROJECT_DIR}/dockerfiles" \
        --destination="${CI_REGISTRY_IMAGE}/${OS}:${OS_VERSION}-${CI_COMMIT_REF_SLUG}" \
        --dockerfile="${CI_PROJECT_DIR}/dockerfiles/${OS}.dockerfile" \
        --reproducible
else
    mkdir -p "dockerfiles/dist/${OS}"
    mkdir -p /var/cache/kaniko
    /kaniko/executor \
        --build-arg="OS_VERSION=${OS_VERSION}" \
        --cache-dir=/var/cache/kaniko \
        --cleanup \
        --destination="localhost/scripts-${OS}:${OS_VERSION}" \
        --digest-file="dockerfiles/dist/${OS}/${OS}-${OS_VERSION}.digest.txt" \
        --dockerfile="dockerfiles/${OS}.dockerfile" \
        --image-name-tag-with-digest-file="dockerfiles/dist/${OS}/${OS}-${OS_VERSION}.name-tag-digest.txt" \
        --image-name-with-digest-file="dockerfiles/dist/${OS}/${OS}-${OS_VERSION}.name-digest.txt" \
        --no-push \
        --reproducible \
        --tarPath="dockerfiles/dist/${OS}/${OS}-${OS_VERSION}.tar"
fi
