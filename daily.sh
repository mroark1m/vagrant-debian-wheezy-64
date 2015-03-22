#! /bin/bash -x
pushd vagrant
vagrant destroy -f
popd

set -e
./build.sh
vboxmanage list vms
vboxmanage unregistervm debian-testing-64
vboxmanage list vms
set +e
vagrant box remove debian-testing-ci
set -e
vagrant box add debian-testing-ci debian-testing-64.box
pushd vagrant
vagrant up
set +e
vagrant ssh default -c "ls /mymirror/foo"
SUCCESS=$?
vagrant destroy -f
echo success? $SUCCESS

exit $SUCCESS
