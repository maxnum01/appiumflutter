# ตั้งค่า Token สำหรับ LINE Notify และข้อความที่ต้องการส่ง
LINE_ACCESSTOKEN="6CAx6Q2yY3AYmJdgT507eFktrbVc8OPCnbCQ6BKg7PA"
# ใช้เพื่อทดสอบ
LINE_ACCESSTOKEN_To_Tassana="FVocAuqmb8LIDy75XDhG293cczbLeI5OIZOurYwp5gA"
# ----------------------------------------------------------------
MESSAGE_SUCCESS="Login Success"
MESSAGE_FAIL="FAIL"
MESSAGE_Null="Output.xml not found"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')  # รับวันที่และเวลาปัจจุบัน

# ตรวจสอบผลการทดสอบจาก RIDE โดยดูจากไฟล์ XML
mypass=$(grep -o '<stat pass="[^"]*' ./result/output.xml | grep -o '[0-9]*$' | head -n 1)

# วิเคราะห์ไฟล์ XML เพื่อรับ log message เกี่ยวกับการทดสอบที่ล้มเหลว
logmessage=$(grep -o '<msg timestamp="[^"]*" level="FAIL">[^<]*Failed[^<]*</msg>' ./result/output.xml | tail -n 1 | sed 's/<[^>]*>//g')

# ตรวจสอบข้อความใน log message และตั้งค่าข้อความสำหรับการแจ้งเตือน
if [[ "$logmessage" == *"Failed to Open App After Installed"* ]]; then
    final_message="$logmessage"
elif [[ "$logmessage" == *"Failed Browser Stack"* ]]; then
    final_message="$logmessage"
elif [[ "$logmessage" == *"Login Failed"* ]]; then
    final_message="$logmessage"
elif [[ "$logmessage" == *"Failed to Open the Application"* ]]; then
    final_message="$logmessage"
elif [[ "$logmessage" == *"Failed, Improvement is underway"* ]]; then
    final_message="$logmessage"
else
    final_message="Failed Browser Stack"
fi

# ค้นหาไฟล์รูปภาพที่ถูกสร้างขึ้นล่าสุด
latest_image=$(ls -t ./Result/appium-screenshot-* | head -n 1)

# ตัดสินใจส่งข้อความไปยัง LINE ตามผลการทดสอบ
if [ "$mypass" == "1" ]; then
  # ผลการทดสอบผ่าน
  curl -v -X POST https://notify-api.line.me/api/notify \
  -H "Authorization: Bearer $LINE_ACCESSTOKEN_To_Tassana" \
  -d "message=$MESSAGE_SUCCESS&stickerId=17844&stickerPackageId=1070"

elif [ -z "$mypass" ]; then
  # ไม่พบไฟล์ output.xml
  curl -v -X POST https://notify-api.line.me/api/notify \
  -H "Authorization: Bearer $LINE_ACCESSTOKEN" \
  -d "message=$MESSAGE_Null : $TIMESTAMP"
  
elif [[ "$final_message" == "Failed Browser Stack" ]]; then
  # พบข้อความ "Failed Browser Stack"
  curl -v -X POST https://notify-api.line.me/api/notify \
  -H "Authorization: Bearer $LINE_ACCESSTOKEN_To_Tassana" \
  -d "message=$final_message : $TIMESTAMP"

else
  # ผลการทดสอบไม่ผ่าน
  if [ -f "$latest_image" ]; then
    # ส่งข้อความพร้อมรูปภาพ
    curl -v -X POST https://notify-api.line.me/api/notify \
    -H "Authorization: Bearer $LINE_ACCESSTOKEN" \
    -F "message=$final_message" \
    -F "imageFile=@$(pwd -W | tr '\\' '/')/$latest_image;type=image/png"
  else
    # ส่งข้อความโดยไม่มีรูปภาพ
    curl -v -X POST https://notify-api.line.me/api/notify \
    -H "Authorization: Bearer $LINE_ACCESSTOKEN" \
    -F "message=$final_message"
  fi
fi
