for i in $(seq 1 10);
do
    response=$(curl -s --location 'https://api.btcmap.org/v3/areas/'$i'' --header 'Content-Type:application/json')
    if [[ $(jq -e . >/dev/null 2>&1 <<<"$response")]]; then
      areaItem=$(echo "$response" | jq 'del(.tags.geo_json)' | jq '.tags')
      echo "$areaItem"
    fi
done
