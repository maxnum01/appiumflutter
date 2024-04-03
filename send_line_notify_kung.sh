#!/bin/bash
echo "hello world" 
LINE_ACCESSTOKEN="akxZtprj0XnStTuDTylQulMMlpTQKZb8ucaoCcBqVjm"
MESSAGE_SUCCESS="Test Passed!"
MESSAGE_FAIL="Test Failed!"

mypass=$(grep -o '<stat pass="[^"]*' .\\result\\output.xml | grep -o '[0-9]*$' | head -n 1)
myfail=$(grep -o '<stat fail="[^"]*' .\\result\\output.xml | grep -o '[0-9]*$')

if [ "$mypass" == "1" ]; then
  curl -X POST https://notify-api.line.me/api/notify \
  -H "Authorization: Bearer $LINE_ACCESSTOKEN" \
  -d "message=$MESSAGE_SUCCESS"
else
  curl -X POST https://notify-api.line.me/api/notify \
  -H "Authorization: Bearer $LINE_ACCESSTOKEN" \
  -d "message=$MESSAGE_FAIL"
fi

echo "mypass: $mypass"
