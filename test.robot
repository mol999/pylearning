*** Settings ***
Library           SeleniumLibrary
Library           String
Library           BuiltIn
Suite Teardown      Close

*** Variables ***
${SERVER}               https://www.saucedemo.com
${BROWSER}              gc
${VALID_USER}           standard_user
${PASSWORD}             secret_sauce   
${FIRSTNAME}            Parinchat
${LASTNAME}             Juntaworn
${ZIP}                  11000

*** Test Cases ***
#? TC-001: Member buy 2 product success
step 0: Open website "https://www.saucedemo.com"
    Open Browser        ${SERVER}       ${BROWSER}      
    ...     options=binary_location="/Users/parinceee/Documents/Chrome/Google Chrome for Testing.app/Contents/MacOS/Google Chrome for Testing";add_experimental_option("detach", True)          
    ...     executable_path=/Users/parinceee/Documents/Chrome/chromedriver

    Maximize Browser Window
    Set Selenium Speed      0.1s 
    Login Page Should Be Open

step 1: Login page
    #step 1.1: Enter valid data in Username text field
    Valid Username
    #step 1.2: Enter valid data in Password text field 
    Input Password
    #step 1.3: Click Login button
    Click Button                        id=login-button
    #step 1.4: Varify default Inventory page "Swag Labs"
    Inventory Page Should Be Open

step 2: Add product to shopping cart in inventory page
    #step 2.1: Add Sauce Labs Backpack 1 ea
    Add Sauce Labs Backpack 1 ea
    #step 2.2: Add Sauce Labs Fleece Jacket 1 ea
    Add Sauce Labs Fleece Jacket 1 ea

step 3: Check your product list in shopping cart
    #step 3.1: Click shopping cart
    Click Link                          //a[@class='shopping_cart_link']
    #step 3.2: Verify "Your Cart" page is show
    Verify Your Cart page is show
    #step 3.3: Verify product details is same inventory page (Sauce Labs Backpack)
    Verify product details is same inventory page (Sauce Labs Backpack)
    #step 3.4: Verify product details is same inventory page (Sauce Labs Fleece Jacket)
    Verify product details is same inventory page (Sauce Labs Fleece Jacket)
    #step 3.5: Click Checkout 
    Click Button                        id=checkout
    #step 3.6: Verify "Checkout: Your Information" page is show
    Verify Your Information page is show

step 4: Enter your Information in Checkout: Your Information page
    #step 4.1: Input valid data in First name text field
    Input valid data in First name text field
    #step 4.2: Input valid data in Last name text field
    Input valid data in Last name text field
    #step 4.3: Input valid data in Zip/Postal Code text field 
    Input valid data in Zip/Postal Code text field 
    #step 4.4: Click Continue button
    Click Element                       id=continue
    #step 4.5: Verify "Checkout: Overview" page is show
    Verify "Checkout: Overview" page is show

step 5: Re-check your product list before confirm checkout in Checkout: Overview page
    #step 5.1: Verify product details is same inventory page (Sauce Labs Backpack)
    Verify product details in overview is same inventory page (Sauce Labs Backpack) 
    #step 5.2: Verify product details is same inventory page (Sauce Labs Fleece Jacket)
    Verify product details in overview is same inventory page (Sauce Labs Fleece Jacket)
    #step 5.5: Verify Price Total
    Verify Price Total in overview
    #step 5.6: Click Finish
    Click Button                        id=finish
step 6: Verify Checkout: Complete! page
    Verify Checkout: Complete page


*** Keywords ***
Close
    Sleep   1s
    Close Browser

#* Login page keyword
Login Page Should Be Open
    # Verify this is a Login page
    #step 0.1: Verify Logo page is "Swag Labs" and position is middle and top page
    Element Text Should Be              //div[@class='login_logo']      Swag Labs
    #step 0.2: Verify Username text field is show
    Page Should Contain Textfield       id=user-name
    #step 0.3: Verify Password text field is show
    Page Should Contain Textfield       id=password
    #step 0.4: Verify Login button is show
    Page Should Contain Button          id=login-button

Valid Username
    #step 1.1: Enter valid data in Username text field
    Input Text                          id=user-name                    ${VALID_USER}
    #step 1.1.1: Varify Username have a value
    Textfield Should Contain            id=user-name                    ${VALID_USER}

Input Password
    #step 1.2: Enter valid data in Password text field 
    Input Text                          id=password                     ${PASSWORD}
    #step 1.2.1: Varify Password have a value
    Textfield Should Contain            id=password                     ${PASSWORD}

#* Inventory Page
Inventory Page Should Be Open
    # Varify default Inventory page "Swag Labs"
    # 1.4.1: Varify Navbar
    Page Should Contain Button          id=react-burger-menu-btn
    Element Text Should Be              //div[@class='app_logo']        Swag Labs
    Page Should Contain Link            //a[@class='shopping_cart_link']

    # 1.4.2: Varify Text "Products" is show next below a navbar and keep left
    Element Text Should Be              //span[@class='title']          Products

    # 1.4.3: Varify source data dropdown is show
    Page Should Contain Element         //select[@class='product_sort_container']

    # 1.4.4: Varify Products card is show
    Page Should Contain Element         //div[@class='inventory_item']

Add Sauce Labs Backpack 1 ea
    #step 2.1.1: Verify title in Sauce Labs Backpack card 
    Element Text Should Be              //div[text()='Sauce Labs Backpack']                                 Sauce Labs Backpack
        # Set var to use other KW
    ${Title_Backpack_In}                Get Text                                                            //div[text()='Sauce Labs Backpack']
    Set Suite Variable                  ${Title_Backpack_Inventory}                                         ${Title_Backpack_In}
    #step 2.1.2: Verify Price in Sauce Labs Backpack card
    Element Text Should Be              //div[@class='inventory_item_price'][text()='29.99']                $29.99
        # Set var to use other KW
    ${Price_Backpack_In}                Get Text                                                            //div[@class='inventory_item_price'][text()='29.99']
    Set Suite Variable                  ${Price_Backpack_Inventory}                                         ${Price_Backpack_In}
    #step 2.1.3: Verify Add to cart button in Sauce Labs Backpack card
    Page Should Contain Button          id=add-to-cart-sauce-labs-backpack                                  Add to cart
    #step 2.1.4: Click Add to cart button to choose item to shopping cart
    Click Button                        id=add-to-cart-sauce-labs-backpack
    #step 2.1.5: Verify shopping cart is increase 1 item 
    Element Text Should Be              //span[@class='shopping_cart_badge']                                1
        # Set var to use other KW
    ${shopping_Cart}                    Get Text                                                            //span[@class='shopping_cart_badge']
    ${shopping_Cart}                    Convert To Number                                                   ${shopping_Cart}                         
    Set Suite Variable                  ${shopping_Cart_Start}                                              ${shopping_Cart}   

Add Sauce Labs Fleece Jacket 1 ea
    #step 2.2.1: Verify title in Sauce Labs Fleece Jacket card
    Element Text Should Be              //div[text()='Sauce Labs Fleece Jacket']                            Sauce Labs Fleece Jacket
        # Set var to use other KW
    ${Title_Jacket_In}                  Get Text                                                            //div[text()='Sauce Labs Fleece Jacket']
    Set Suite Variable                  ${Title_Jacket_Inventory}                                           ${Title_Jacket_In}
    #step 2.2.2: Verify Price in Sauce Labs Fleece Jacket card
    Element Text Should Be              //div[@class='inventory_item_price'][text()='49.99']                $49.99
        # Set var to use other KW
    ${Price_Jacket_In}                  Get Text                                                            //div[@class='inventory_item_price'][text()='49.99']
    Set Suite Variable                  ${Price_Jacket_Inventory}                                           ${Price_Jacket_In}
    #step 2.2.3: Verify Add to cart button in Sauce Labs Fleece Jacket card
    Page Should Contain Button          id=add-to-cart-sauce-labs-fleece-jacket                             Add to cart
    #step 2.2.4: Click Add to cart button to choose item to shopping cart
    Click Button                        id=add-to-cart-sauce-labs-fleece-jacket  
    #step 2.1.5: Verify shopping cart is increase 1 item
    ${Shopping_Cart}                    Get Text                                                            //span[@class='shopping_cart_badge']                        
    ${Shopping_Cart}                    Convert To Number                                                   ${Shopping_Cart}                                            #? get ค่าตะกร้าล่าสุดออกมาเป็น num
        #  shopping cart is increase 1 item
    ${Cart_Plus_One}                    Evaluate                                                            ${shopping_Cart_Start} + 1                                  #? นำค่าที่เก็บด้านบนมา +1                     
    Should Be True                      ${Cart_Plus_One} == ${Shopping_Cart}                                                                                            #? นำ 2 ค่านี้มาเทียบกัน และควรจะเท่ากัน

#* Your Cart page
#step 3.2: Verify "Your Cart" page is show
Verify Your Cart page is show
    #step 3.2.1: Varify Text "Your Cart" is show
    Element Text Should Be              //span[@class='title'][text()='Your Cart']                          Your Cart
    #step 3.2.2: Verify 2 item is in the shopping cart
    Element Text Should Be              //span[@class='shopping_cart_badge'][text()='2']                    2                                                           #? เช็คว่ามี 2 ค่าอยู่ในตะกร้า
    #step 3.2.3: Verify product card that you choose is show = 2   
    ${count}                            Get Element Count                                                   //div[@class='cart_item']                                   #? เช็คว่า card item ขึ้นมา 2 อัน                                            
    Should Be True                      ${count} == 2

#step 3.3: Verify product details is same inventory page (Sauce Labs Backpack)
Verify product details is same inventory page (Sauce Labs Backpack)
    #step 3.3.1: Verify QTY is 1
    Element Text Should Be              //div[text()='Sauce Labs Backpack']/../../../div[@class='cart_quantity']            1
    #step 3.3.2: Verify title in Sauce Labs Backpack card
    Element Text Should Be              //div[text()='Sauce Labs Backpack']                                                 Sauce Labs Backpack
    ${Title_Backpack_Cart}              Get Text                                                                            //div[text()='Sauce Labs Backpack']
    Should Be Equal As Strings          ${Title_Backpack_Cart}                                                              ${Title_Backpack_Inventory}                 #? เทียบว่าเหมือนหน้า Inventory ไหม
    #step 3.3.3: Verify Price in Sauce Labs Backpack card 
    Element Text Should Be              //div[text()='Sauce Labs Backpack']/../..//div[@class='inventory_item_price']       $29.99                                 
    ${Price_Backpack_Cart}              Get Text                                                                            //div[text()='Sauce Labs Backpack']/../..//div[@class='inventory_item_price']
    Should Be Equal As Strings          ${Price_Backpack_Cart}                                                              ${Price_Backpack_Inventory}                 #? เทียบว่าเหมือนหน้า Inventory ไหม
    #step 3.3.4: Verify Remove button in Sauce Labs Backpack card
    Page Should Contain Button          id=remove-sauce-labs-backpack                                                       Remove

#step 3.4: Verify product details is same inventory page (Sauce Labs Fleece Jacket)
Verify product details is same inventory page (Sauce Labs Fleece Jacket)
    #step 3.4.1: Verify QTY is 1
    Element Text Should Be              //div[text()='Sauce Labs Fleece Jacket']/../../../div[@class='cart_quantity']       1
    #step 3.4.2: Verify title in Sauce Labs Fleece Jacket card 
    Element Text Should Be              //div[text()='Sauce Labs Fleece Jacket']                                            Sauce Labs Fleece Jacket
    ${Title_Jacket_Cart}                Get Text                                                                            //div[text()='Sauce Labs Fleece Jacket']
    Should Be Equal As Strings          ${Title_Jacket_Cart}                                                                ${Title_Jacket_Inventory}                   #? เทียบว่าเหมือนหน้า Inventory ไหม
    #sstep 3.4.3: Verify Price in Sauce Labs Fleece Jacket card 
    Element Text Should Be              //div[text()='Sauce Labs Fleece Jacket']/../..//div[@class='inventory_item_price']  $49.99                               
    ${Price_Jacket_Cart}                Get Text                                                                            //div[text()='Sauce Labs Fleece Jacket']/../..//div[@class='inventory_item_price']
    Should Be Equal As Strings          ${Price_Jacket_Cart}                                                                ${Price_Jacket_Inventory}                   #? เทียบว่าเหมือนหน้า Inventory ไหม
    #step 3.4.4: Verify Remove button in Sauce Labs Fleece Jacket card
    Page Should Contain Button          id=remove-sauce-labs-fleece-jacket                                                  Remove

#step 3.6: Verify "Checkout: Your Information" page is show
Verify Your Information page is show
    #step 3.6.1: Varify Text "Checkout: Your Information" is show
    Element Text Should Be               //span[@class='title']                         Checkout: Your Information
    #step 3.6.2: Verify Checkout information form is show 
    Page Should Contain Element          //div[@class='checkout_info']  

#* Checkout: Your Information page
#step 4.1: Input valid data in First name text field
Input valid data in First name text field
    Input Text                           id=first-name                                  ${FIRSTNAME}
    #step 4.1.1: Varify First Name have a value
    Textfield Should Contain             id=first-name                                  ${FIRSTNAME}

#step 4.2: Input valid data in Last name text field
Input valid data in Last name text field
    Input Text                           id=last-name                                   ${LASTNAME}
    #step 4.2.1: Varify Last Name have a value
    Textfield Should Contain             id=last-name                                   ${LASTNAME}

#step 4.3: Input valid data in Zip/Postal Code text field 
Input valid data in Zip/Postal Code text field 
    Input Text                           id=postal-code                                 ${ZIP}
    #step 4.3.1: Varify Zip/Postal Code have a value
    Textfield Should Contain             id=postal-code                                 ${ZIP}

#step 4.5: Verify "Checkout: Overview" page is show
Verify "Checkout: Overview" page is show
    #step 4.5.1: Varify Text "Checkout: Overview" is show
    Element Text Should Be               //span[@class='title']                         Checkout: Overview
    #step 4.5.2: Verify product card that you choose is show = 2
    ${count}                             Get Element Count                              //div[@class='cart_item']                                              
    Should Be True                       ${count} == 2

#* Overview page
#step 5.1: Verify product details is same inventory page (Sauce Labs Backpack)
Verify product details in overview is same inventory page (Sauce Labs Backpack) 
    #step 5.1.1: Verify QTY is 1
    Element Text Should Be              //div[text()='Sauce Labs Backpack']/../../../div[@class='cart_quantity']            1
    #step 5.1.2: Verify title in Sauce Labs Backpack card / ต้องเช็คว่าเหมือนหน้าก่อนไหมด้วย
    Element Text Should Be              //div[text()='Sauce Labs Backpack']                                                 Sauce Labs Backpack
    ${Title_Backpack_Overview}          Get Text                                                                            //div[text()='Sauce Labs Backpack']
    Should Be Equal As Strings          ${Title_Backpack_Overview}                                                          ${Title_Backpack_Inventory}             #? เทียบว่าเหมือนหน้า Inventory ไหม
    #step 5.1.3: Verify Price in Sauce Labs Backpack card / ต้องเช็คว่าเหมือนหน้าก่อนไหมด้วย
    Element Text Should Be              //div[text()='Sauce Labs Backpack']/../..//div[@class='inventory_item_price']       $29.99                                 
    ${Price_Backpack_Overview}          Get Text                                                                            //div[text()='Sauce Labs Backpack']/../..//div[@class='inventory_item_price']
    Should Be Equal As Strings          ${Price_Backpack_Overview}                                                          ${Price_Backpack_Inventory}             #? เทียบว่าเหมือนหน้า Inventory ไหม

#step 5.2: Verify product details is same inventory page (Sauce Labs Fleece Jacket)
Verify product details in overview is same inventory page (Sauce Labs Fleece Jacket)
    #step 5.2.1: Verify QTY is 1
    Element Text Should Be              //div[text()='Sauce Labs Fleece Jacket']/../../../div[@class='cart_quantity']       1
    #step 5.2.2: Verify title in Sauce Labs Fleece Jacket card / ต้องเช็คว่าเหมือนหน้าก่อนไหมด้วย
    Element Text Should Be              //div[text()='Sauce Labs Fleece Jacket']                                            Sauce Labs Fleece Jacket
    ${Title_Jacket_Overview}            Get Text                                                                            //div[text()='Sauce Labs Fleece Jacket']
    Should Be Equal As Strings          ${Title_Jacket_Overview}                                                            ${Title_Jacket_Inventory}               #? เทียบว่าเหมือนหน้า Inventory ไหม
    #step 5.2.3: Verify Price in Sauce Labs Fleece Jacket card / ต้องเช็คว่าเหมือนหน้าก่อนไหมด้วย
    Element Text Should Be              //div[text()='Sauce Labs Fleece Jacket']/../..//div[@class='inventory_item_price']  $49.99                               
    ${Price_Jacket_Overview}            Get Text                                                                            //div[text()='Sauce Labs Fleece Jacket']/../..//div[@class='inventory_item_price']
    Should Be Equal As Strings          ${Price_Jacket_Overview}                                                            ${Price_Jacket_Inventory}               #? เทียบว่าเหมือนหน้า Inventory ไหม
#step 5.5: Verify Price Total
Verify Price Total in overview
    #step 5.5.1: Verify Item total price (if item price is same inventory page (in #step 5.1.3 and #step 5.2.3))
        # Get Item_Total_Price
    ${total_price}    Get Text              xpath=//div[@class='summary_subtotal_label']
    ${total_price}    Remove String         ${total_price}      Item       total       :       $                #? ลบให้เหลือแค่เลขและเอาไป convert เพื่อคำนวณ
    ${total_price}    Convert To Number     ${total_price}
    # Log To console      \n ${total_price}
        # Convert price Sauce Labs Backpack to number
    ${price_Sauce_Labs_Backpack}        Get Text                //div[text()='Sauce Labs Backpack']/../..//div[@class='inventory_item_price']
    ${price_Sauce_Labs_Backpack}        Remove String           ${price_Sauce_Labs_Backpack}        $
    ${price_Sauce_Labs_Backpack}        Convert To Number       ${price_Sauce_Labs_Backpack}
    # Log To console      \n ${price_Sauce_Labs_Backpack}
        # Convert price Sauce Labs Fleece Jacket to number
    ${price_Sauce_Labs_Fleece_Jacket}   Get Text                //div[text()='Sauce Labs Fleece Jacket']/../..//div[@class='inventory_item_price']
    ${price_Sauce_Labs_Fleece_Jacket}   Remove String           ${price_Sauce_Labs_Fleece_Jacket}   $
    ${price_Sauce_Labs_Fleece_Jacket}   Convert To Number       ${price_Sauce_Labs_Fleece_Jacket}
    # Log To console      \n ${price_Sauce_Labs_Fleece_Jacket}
        # Compare price should be equal
    Should Be True      ${total_price} == ${price_Sauce_Labs_Backpack} + ${price_Sauce_Labs_Fleece_Jacket}

    #step 5.5.2: Verify Tax
    ${Tax_cal}          evaluate             (${total_price} * 8)/100
    ${Tax_cal}          Convert To Number    ${Tax_cal}
    ${Tax_cal}          evaluate    "%.2f" % ${Tax_cal}         #? ปัดเศษเหลือ 2
        # Compare tax 
    ${Tax}              Get Text            //div[@class='summary_tax_label']
    ${Tax}              Remove String       ${Tax}          Tax     :       $
    ${Tax}              Convert To Number   ${Tax}
    Should Be True      ${Tax_cal} == ${Tax}

    #step 5.5.3: Verify Total Price (Item total price + Tax)
    ${total_cal}        evaluate            ${total_price} + ${Tax}
    ${total_cal}        Convert To Number   ${total_cal}
    ${total_cal}        evaluate    "%.2f" % ${total_cal}       #? ปัดเศษเหลือ 2
        #Compare total price
    ${total}            Get Text            //div[@class='summary_total_label']
    ${total}            Remove String       ${total}        Total    :      $
    ${total}            Convert To Number   ${total}
    ${total}            evaluate    "%.2f" % ${total}
    Should Be True      ${total} == ${total_cal}

#* Complete page
#step 6: Verify Checkout: Complete! page
Verify Checkout: Complete page
    #step 6.1: Varify Text "Checkout: Complete!" is show 
    Element Text Should Be              //span[text()='Checkout: Complete!']                Checkout: Complete!
    #step 6.2: Verify The shopping cart is Empty
    Element Should Not Be Visible       //span[@class='shopping_cart_badge']                                            #? เช็คว่า span tag ไม่ขึ้น = ไม่มีสินค้าอยู่ในตะกร้า                                    
    #step 6.3: Verify image is show
    Page Should Contain Image           //img[@class='pony_express']
    #step 6.4: Verify text "Thank you for your order!" is show in the middle page
    Element Text Should Be              //h2[@class='complete-header']                      Thank you for your order!
    #step 6.5: Verify "Back Home" button is show
    Page Should Contain Button          id=back-to-products