for i in $(seq 1 10);
do
    response=$(curl -s --location 'https://api.btcmap.org/v3/areas/'$i'' --header 'Content-Type:application/json')
    if [[ $(jq -e . <<<"$response" >/dev/null 2>&1; echo $?) -eq 0 && $(echo "$response" | jq 'has(.tags)') ]]; then
      areaItem=$(echo "$response" | jq 'del(.tags.geo_json)' | jq '.tags')
      echo "$areaItem"
    fi
done
