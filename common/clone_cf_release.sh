#!/bin/bash -ex

CF_RELEASE_URL=${CF_RELEASE_URL:-https://github.com/cloudfoundry/cf-release.git}
CF_RELEASE_BRANCH=${CF_RELEASE_BRANCH:-master}
CF_RELEASE_USE_HEAD=${CF_RELEASE_USE_HEAD:-no}

CF_SERVICES_RELEASE_URL=${CF_SERVICES_RELEASE_URL:-https://github.com/cloudfoundry/cf-services-contrib-release.git}
CF_SERVICES_RELEASE_BRANCH=${CF_SERVICES_RELEASE_BRANCH:-master}
CF_SERVICES_RELEASE_USE_HEAD=${CF_SERVICES_RELEASE_USE_HEAD:-no}

ruby_version=`rbenv version | cut -f1 -d" "` # overwrite .ruby-version

if [ ! -d cf-release ]; then
    git clone ${CF_RELEASE_URL}
    (
        cd cf-release
        git checkout -f ${CF_RELEASE_BRANCH}

        if [ $CF_RELEASE_USE_HEAD != "no" ]; then
            ./update
            RBENV_VERSION=$ruby_version bundle install
            RBENV_VERSION=$ruby_version bundle exec bosh -n create release --force
        fi
    )
fi

if [ ! -d cf-services-contrib-release ]; then
    git clone ${CF_SERVICES_RELEASE_URL}
    (
        cd cf-services-contrib-release
        git checkout -f ${CF_SERVICES_RELEASE_BRANCH}

        if [ $CF_SERVICES_RELEASE_USE_HEAD != "no" ]; then
            ./update
            RBENV_VERSION=$ruby_version bundle install
            RBENV_VERSION=$ruby_version bundle exec bosh -n create release --force
        fi
    )
fi
