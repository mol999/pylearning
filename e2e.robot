*** Settings ***
Library           SeleniumLibrary

*** Variables ***
${BROWSER}        Chrome
${URL}            https://www.saucedemo.com/
${USERNAME}       standard_user
${PASSWORD}       secret_sauce      

*** Test Cases ***
Login Test
    Open Browser    ${URL}    ${BROWSER}      options=binary_location=r"C:\\Chrome\\chrome-win64\\chrome.exe";add_experimental_option("detach", True)    executable_path=C:\\Chrome\\chromedriver-win64\\chromedriver-win64\\chromedriver.exe
    # Page Should Contain Element     //div[@class='login_logo'][text()='Swag Labs']
    Element Text Should Be     locator=//div[@class='login_logo']      expected= Swag Labs
    # Sleep     10s
    # C:\\Chrome\\chromedriver-win64\\chromedriver-win64\\chromedriver.exe
    # C:\\Chrome\\chrome-win64\\chrome.exe
    # Input Text      id="user-name" ${USERNAME}
    # Input Password  id=password    ${PASSWORD}
    # Click Button    id=login-button
    # Page Should Contain Element  id="menu_button_container"  
    # [Teardown]    Close Browser