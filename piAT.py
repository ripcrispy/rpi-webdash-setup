#!/usr/bin/env python
import commands

webbrowser = "iceweasel"
pgrepcmd = "pgrep %s " % (webbrowser)
process = commands.getoutput(pgrepcmd)
autotaskusername = "user@domain.com"
autotaskpassword = "nope"

if process == "":
        print "Starting %s" % (webbrowser)
        from selenium import webdriver
        from selenium.webdriver.common.keys import Keys
        from selenium.webdriver import ActionChains

        # Added Dependancies
        from selenium.webdriver.support.wait import WebDriverWait
        from selenium.webdriver.common.by import By
        from selenium.webdriver.support import expected_conditions as EC

        # Start Iceweasel
        driver = webdriver.Firefox()
        actions = ActionChains(driver)

        # Goto AT Website
        driver.get("https://ww6.autotask.net")
        assert "Autotask" in driver.title # Confirmed Autotask is in the Web Page Title

        # Enter Fullscreen
        browserFullscreen = driver.find_element_by_tag_name('html')
        browserFullscreen.send_keys (Keys.F11)

        # Enter Login Credentials
        autotaskUser = driver.find_element_by_name('UserName')
        autotaskUser.send_keys(autotaskusername)
        autotaskPass = driver.find_element_by_name('Password')
        autotaskPass.send_keys (autotaskpassword + Keys.RETURN)

        # Wait using selenium.webdriver.support.wait
        wait = WebDriverWait(driver, 15000)

        # Hover over context menu
        presMenu = wait.until(EC.presence_of_element_located((By.ID, "DashboardContextMenu_Menu")))
        ActionChains(driver).move_to_element(presMenu).perform()

        # Hover and Wait
        wait = WebDriverWait(driver, 3000)

        # Hover Presentation Mode Button
        presMenuButtonHover = wait.until(EC.presence_of_element_located((By.ID, "DashboardContextMenu_PresentationModeButton")))
        ActionChains(driver).move_to_element(presMenuButtonHover).click().perform()

        # Hover over button
        wait = WebDriverWait(driver, 3000)

        # Select Presentation Mode
        presMenuButtonSelect = wait.until(EC.presence_of_element_located((By.ID, "EnterPresentationModeButton")))
        ActionChains(driver).move_to_element(presMenuButtonSelect).click().perform()

        exit()
else:
        print "%s is already running" % (webbrowser)
        exit()
