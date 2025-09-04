for i in $(seq 1 10);
do
    curl -s --location 'https://api.btcmap.org/rpc' --header 'Content-Type:application/json' --data '{"jsonrpc":"2.0","method":"get_area_dashboard","params":{"area_id":'$i'},"id":1}' | jq '.result.total_elements'
done


