rm api/curve/curve.db
./control_conda.sh stop
sleep 1
rm api/curve/web -rf
rm pylib_version
./control_conda.sh start
