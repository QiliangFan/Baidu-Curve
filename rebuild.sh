# find . | xargs -n 1 git clean -f > /dev/null 2>&1
./control_conda.sh stop
sleep 1
rm api/curve/web -rf
rm pylib_version
./control_conda.sh start
