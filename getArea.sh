for i in $(seq 1 10);
do
    curl -s --location 'https://api.btcmap.org/v3/areas/'$i'' --header 'Content-Type:application/json'
done
