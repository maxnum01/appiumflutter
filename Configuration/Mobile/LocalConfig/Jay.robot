*** Variables ***
${ENV}            Staging    # Staging, Production
${LOGIN}          PINTel    # OTP, PINTel, PINEmail, Auto, None
${LANGUAGE}       EN    # TH, EN
${MOBILE}         Postpaid    # Postpaid, Prepaid, FBB
${DEVICE}         Real    # Real, Visual, BrowserStack
${OS}             Android    # Android, iOS
${General_TimeOut}    60s
${Mobilenumber_Postpaid}    0932019857
${Mobilenumber_Prepaid}    0659333673
&{SuspendBarredRequest}    Moblie=0934000845    Email=    PIN=111111
&{SuspendCreditLimitted}    Moblie=0934000833    Email=    PIN=111111
${JsonfilePath}    /Users/prasertsakph/myais2.0/Configuration/DataInsurance.json
