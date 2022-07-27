*** Settings ***
Resource                      ../resources/api_common.robot 
Resource                      ../resources/common.robot     
Suite Setup                   Run Keywords 
...                           Setup Browser  
...                           Authenticate into Salesforce    
Suite Teardown                End suite

*** Test Cases ***
Create Account via API and capture Account ID
    ${account_data}=      SF API Create Account Record
    ${account_id}=        Get From Dictionary         ${account_data}    id 
    Set Suite Variable    ${account_id}

SOQL Query and paratermize JSON response
    ${soql_response}=    SF API SOQL Query Account Record
    ${name}=       Get From Dictionary    ${soql_response}    Name
    Set Suite Variable                    ${name}

Validate Account Record Created in UI 
    Home 
    ClickText    Accounts 
    VerifyText    ${name} 
    ClickText     ${name}
    Clicktext     Delete
    ClickText     Delete    anchor=Cancel
