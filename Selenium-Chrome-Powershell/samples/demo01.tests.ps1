Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

Import-Module Selenium
Import-Module Pester

$Global:testURL = 'https://google.de'
$Global:Width = 1360
$Global:Height = 1020

Describe 'Simple Google search' {
    BeforeAll {
        $chromeOptions = New-Object OpenQA.Selenium.Chrome.ChromeOptions

        # https://peter.sh/experiments/chromium-command-line-switches/
        $chromeOptions.AddArguments('headless', 'disable-gpu', 'no-sandbox', 'enable-logging', 'no-default-browser-check', 'no-first-run', 'remote-debugging-address=0.0.0.0', 'remote-debugging-port=9222')
        $driver = New-Object OpenQA.Selenium.Chrome.ChromeDriver($chromeOptions)
        $driver.Manage().Window.Size = new-Object System.Drawing.Size($Global:Width, $Global:Height)
        $driver.Navigate().GoToUrl($Global:testURL)
    }

    It "Should open $Global:testURL" {
        $driver.Title | Should -Be 'Google'
    }

    Describe 'Cookie banner handling' {

        BeforeAll {
            $cookieBtn = $driver.FindElementByXPath('//*[@id="L2AGLb"]/div')
        }

        It 'Can find the cookie warning' {
            $cookieBtn | Should -Not -BeNullOrEmpty
            $cookieBtn.Text | Should -Be 'Alle akzeptieren'
        }

        It 'Can accept the cookie warning' {
            $cookieBtn.Click()
        }
    }

    Describe 'Perform a search' {

        BeforeAll {
            $search = $driver.FindElementByName('q')
        }

        It 'Can find the search input' {
            $search | Should -Not -BeNullOrEmpty
        }

        It 'Can enter search term and submit' {
            $search.SendKeys('Selenium Pester Powershell')
            $search.Submit()
        }
    }

    AfterAll {
        $driver.Close()
        $driver.Quit()
    }
}

