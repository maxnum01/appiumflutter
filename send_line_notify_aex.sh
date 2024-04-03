#!/bin/bash

# ตั้งค่า Token สำหรับ LINE Notify
LINE_ACCESSTOKEN="6CAx6Q2yY3AYmJdgT507eFktrbVc8OPCnbCQ6BKg7PA"
LINE_ACCESSTOKEN_To_Tassana="FVocAuqmb8LIDy75XDhG293cczbLeI5OIZOurYwp5gA"

# ข้อความที่ต้องการส่ง
MESSAGE_SUCCESS="Login Success"
MESSAGE_FAIL="FAIL"
MESSAGE_Null="Output.xml not found"

# รับวันที่และเวลาปัจจุบัน
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

# ตั้งชื่อไฟล์รายงานประจำวัน
REPORT_FILE="./report_$(date '+%Y-%m-%d').txt"

# ตรวจสอบผลการทดสอบจาก RIDE โดยดูจากไฟล์ XML
mypass=$(grep -o '<stat pass="[^"]*' ./result/output.xml | grep -o '[0-9]*$' | head -n 1)
logmessage=$(grep -o '<msg timestamp="[^"]*" level="FAIL">[^<]*Failed[^<]*</msg>' ./result/output.xml | tail -n 1 | sed 's/<[^>]*>//g')

# ตัดสินใจข้อความที่จะส่งตาม log message
if [[ "$logmessage" == *"Failed to Open App After Installed"* ]]; then
    final_message="$logmessage"
elif [[ "$logmessage" == *"Failed Browser Stack"* ]]; then
    final_message="$logmessage : $TIMESTAMP"
elif [[ "$logmessage" == *"Login Failed"* ]]; then
    final_message="$logmessage"
elif [[ "$logmessage" == *"Failed to Open the Application"* ]]; then
    final_message="$logmessage"
elif [[ "$logmessage" == *"Failed, Improvement is underway"* ]]; then
    final_message="$logmessage"
else
    final_message="!!!Failed Browser Stack!!!"
fi

# ค้นหาไฟล์รูปภาพที่ถูกสร้างขึ้นล่าสุด
latest_image=$(ls -t ./Result/appium-screenshot-* | head -n 1)

# บันทึกผลการทดสอบลงไฟล์รายงาน
if [ -z "$mypass" ]; then
    echo "$TIMESTAMP, NULL, $MESSAGE_Null" >> "$REPORT_FILE"
elif [ "$mypass" == "1" ]; then
    echo "$TIMESTAMP, PASS, $MESSAGE_SUCCESS" >> "$REPORT_FILE"
else
    echo "$TIMESTAMP, FAIL, $final_message" >> "$REPORT_FILE"
fi

# ฟังก์ชั่นส่งรายงานผ่าน LINE Notify
send_report() {
    PASS_COUNT=$(grep -c ", PASS," "$REPORT_FILE")
    FAIL_COUNT=$(grep -c ", FAIL," "$REPORT_FILE")
    MESSAGE="Summary for $(date '+%Y-%m-%d'): Pass = $PASS_COUNT, Fail = $FAIL_COUNT"

    curl -v -X POST https://notify-api.line.me/api/notify \
    -H "Authorization: Bearer $LINE_ACCESSTOKEN_To_Tassana" \
    -d "message=$MESSAGE"
}

# ตัดสินใจส่งข้อความไปยัง LINE ตามผลการทดสอบ
# เพิ่มตรรกะสำหรับเมื่อได้ "Failed Browser Stack" ให้ส่งไปยัง LINE_ACCESSTOKEN_To_Tassana
if [[ "$final_message" == *"Failed Browser Stack"* ]]; then
    curl -v -X POST https://notify-api.line.me/api/notify \
    -H "Authorization: Bearer $LINE_ACCESSTOKEN_To_Tassana" \
    -d "message=$final_message"
elif [ "$mypass" == "1" ]; then
    # ผลการทดสอบผ่าน
    curl -v -X POST https://notify-api.line.me/api/notify \
    -H "Authorization: Bearer $LINE_ACCESSTOKEN_To_Tassana" \
    -d "message=$MESSAGE_SUCCESS&stickerId=17844&stickerPackageId=1070"
elif [ -f "$latest_image" ]; then
    # ส่งข้อความพร้อมรูปภาพ
    curl -v -X POST https://notify-api.line.me/api/notify \
    -H "Authorization: Bearer $LINE_ACCESSTOKEN_To_Tassana" \
    -F "message=$final_message" \
    -F "imageFile=@$(pwd -W | tr '\\' '/')/$latest_image;type=image/png"
else
    # ส่งข้อความโดยไม่มีรูปภาพ
    curl -v -X POST https://notify-api.line.me/api/notify \
    -H "Authorization: Bearer $LINE_ACCESSTOKEN_To_Tassana" \
    -F "message=$final_message"
fi

# เรียกใช้ฟังก์ชั่นส่งรายงานหากมีการระบุอาร์กิวเมนต์เฉพาะ
if [ "$1" == "send_report" ]; then
    send_report
fi
