#! /bin/bash -x
set -e
./build.sh
vboxmanage list vms
vboxmanage unregistervm debian-testing-64
vboxmanage list vms
set +e
vagrant box remove debian-testing-ci
set -e
vagrant box add debian-testing-ci debian-testing-64.box
cd vagrant
vagrant up
set +e
vagrant ssh default -c "ls /"
SUCCESS=$?
vagrant destroy -f
echo success? $SUCCESS

exit $SUCCESS
