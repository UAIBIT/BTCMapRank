for i in $(seq 1 10);
do
    response = $(curl -s --location 'https://api.btcmap.org/v3/areas/'$i'' --header 'Content-Type:application/json')
    areaItem = $(echo $response | jq '.tags del(.tags.geojson)')
    echo $areaItem
done
