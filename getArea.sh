for i in $(seq 1 10);
do
    response=$(curl -s --location 'https://api.btcmap.org/v3/areas/'$i'' --header 'Content-Type:application/json')
    areaItem=$(echo "$response" | jq 'del(.tags.geojson)' | jq '.tags')
    echo "$areaItem"
done
