rm -rf xcelium.d waves.shm
xrun hdl/*sv test/*sv -gui -access +rw 
sleep 10
$echo "Aqui"
rm -rf xcelium.d waves.shm
