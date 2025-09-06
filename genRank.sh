jq 'sort_by(-.merchantCount)' rankingItems.json > ranking.json
jq '[.[] | select(.type == "country")]' ranking.json > rankingCountry.json
jq '[.[] | select(.type == "community")]' ranking.json > rankingCommunity.json
echo "{}" > orgs.json
jq -c '.' rankingCommunity.json | while read -r i; do
    org=$(echo "$i" | jq '.organization // "noOrg"' -r)
    merchantCount=$(echo $i | jq '.merchantCount // 0')
    oldMerchantCount=$(jq '."'"$org"'".merchantCount // 0' orgs.json)
    echo "$(jq '. += {"'"$org"'": {"name":"'"$org"'","merchantCount":'"$oldMerchantCount"'}}' orgs.json)" > orgs.json
    echo "$(jq '."'"$org"'".merchantCount += '"$merchantCount"'' orgs.json)" > orgs.json
done
#echo "$(jq 'to_entries | map(.value)' orgs.json)" > orgs.json
#jq 'sort_by(-.merchantCount)' orgs.json > rankingOrgs.json
