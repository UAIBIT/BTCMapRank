touch "rankingItems.json"
touch "ranking.json"
[[ $(jq -e . <<< rankingItems.json >/dev/null 2>&1; echo $?) -ne 0 && $(cat rankingItems.json | jq 'length') -eq 0 ]] && {
   echo "[]" > rankingItems.json
}
rankingItems=$(jq "." rankingItems.json)
for i in $(seq 0 10);
do
    response=$(curl -s --location 'https://api.btcmap.org/v3/areas/'$i'' --header 'Content-Type:application/json')
    areaItem='{"id":'$i',"type":null,"merchantCount":0, "name": null}'
    [[ $(jq -e . <<<"$response" >/dev/null 2>&1; echo $?) -eq 0 && $(echo "$response" | jq 'has("tags")' -r) = "true" ]] && {
      areaItem=$(echo "$response" | jq 'del(.tags.geo_json)' | jq '.tags')
      merchantCount=$(curl -s --location 'https://api.btcmap.org/rpc' --header 'Content-Type:application/json' --data '{"jsonrpc":"2.0","method":"get_area_dashboard","params":{"area_id":'$i'},"id":1}' | jq '.result.total_elements')
      areaItemId=$(echo "$response" | jq '.id')
      areaItem=$(echo "$areaItem" | jq '.id  = '"$areaItemId"'')
      areaItem=$(echo "$areaItem" | jq '.merchantCount  = '"$merchantCount"'')
      echo "$areaItem"
    }
   rankingItems=$(echo $rankingItems | jq '.['$i'] = '"$areaItem"'')
done
echo "$rankingItems" > rankingItems.json
echo "$rankingItems" | jq 'sort_by(-.merchantCount)' > ranking.json
