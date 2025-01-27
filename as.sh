curl "https://www.adultswim.com/api/schedule/onair?days=7" | jq '[.data[] | {showTitle, datetime}]' | less
