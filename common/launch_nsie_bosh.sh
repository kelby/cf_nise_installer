#!/bin/bash -ex

NISE_DOMAIN=vcap.me

sed "s/192.168.10.10/${NISE_IP_ADDRESS}/g" manifests/micro.yml > manifests/deploy.yml
sed "s/192.168.10.10/${NISE_IP_ADDRESS}/g" manifests/micro_services.yml > manifests/deploy_services.yml

if (! sed --version 1>/dev/null 2>&1); then
    # not a GNU sed
    sed -i '' "s/192.168.10.11/${NISE_IP_ADDRESS}/g" manifests/deploy_services.yml
else
    sed -i "s/192.168.10.11/${NISE_IP_ADDRESS}/g" manifests/deploy_services.yml
fi

if [ "${NISE_DOMAIN}" != "" ]; then
    if (! sed --version 1>/dev/null 2>&1); then
        # not a GNU sed
        sed -i '' "s/${NISE_IP_ADDRESS}.xip.io/${NISE_DOMAIN}/g" manifests/deploy.yml
        sed -i '' "s/${NISE_IP_ADDRESS}.xip.io/${NISE_DOMAIN}/g" manifests/deploy_services.yml
    else
        sed -i "s/${NISE_IP_ADDRESS}.xip.io/${NISE_DOMAIN}/g" manifests/deploy.yml
        sed -i "s/${NISE_IP_ADDRESS}.xip.io/${NISE_DOMAIN}/g" manifests/deploy_services.yml
    fi
fi

if [ "${NISE_PASSWORD}" != "" ]; then
    if (! sed --version 1>/dev/null 2>&1); then
        # not a GNU sed
        sed -i '' "s/c1oudc0w/${NISE_PASSWORD}/g" manifests/deploy.yml
        sed -i '' "s/c1oudc0w/${NISE_PASSWORD}/g" manifests/deploy_services.yml
    else
        sed -i "s/c1oudc0w/${NISE_PASSWORD}/g" manifests/deploy.yml
        sed -i "s/c1oudc0w/${NISE_PASSWORD}/g" manifests/deploy_services.yml
    fi
fi
