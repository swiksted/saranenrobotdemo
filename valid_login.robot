*** Settings ***
Library           Selenium2Library

Test Teardown     Close Browser

*** Variables ***
${VALID USERNAME}    demo
${VALID PASSWORD}    mode
${LOGIN PAGE}        http://127.0.0.1:7272
${WELCOME PAGE}      ${LOGIN PAGE}/welcome.html
${ERROR PAGE}        ${LOGIN PAGE}/error.html

*** Test Cases ***

Valid Login
    Go To Login Page
    Input Credentials And Log In    ${VALID USERNAME}    ${VALID PASSWORD}
    Welcome Page SHould Be Open     

Invalid Login - Wrong Password
    Log In And Expect Error    demo     wrongpass  

Invalid Login - Wrong Username
    Log In And Expect Error    wronguser    mode

Invalid Login - Empty Password
    Log In And Expect Error    demo     ${EMPTY}
    
Invald Login - Empty Username
    Log In And Expect Error    ${EMPTY}    mode

Invalid Login - EMpty username AND password
    Log In And Expect Error     ${EMPTY}    ${EMPTY}

*** Keywords ***

Go To Login Page
    Open Browser    http://127.0.0.1:7272

Input Credentials And Log In
    [Arguments]    ${username}    ${password}
    Comment       Using username 'demo' and password 'mode'
    Input Text    username_field    ${username}
    Input Text    password_field    ${password}
    Click Button    login_button

Welcome Page Should Be Open
    Wait Until keyword Succeeds    3x    2 Sec    Location Should Be    ${WELCOME PAGE}
    Page Should Contain    Welcome

Error Page Should Be Open
    Page Should Contain    Error
    Location Should Be     ${ERROR PAGE}

Log In And Expect Error
    [Arguments]    ${username}    ${password}

    Go To Login Page
    Input Credentials And Log In    ${username}    ${password}
    Error Page Should Be Open

