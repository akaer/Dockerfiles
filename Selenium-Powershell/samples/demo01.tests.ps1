Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

Import-Module Selenium
Import-Module Pester

$Global:testURL = 'https://google.de'

Describe "All in one Test" {

    BeforeAll {
        $chromeOptions = New-Object OpenQA.Selenium.Chrome.ChromeOptions
        $driver = New-Object OpenQA.Selenium.Chrome.ChromeDriver($chromeOptions)
        $driver.Manage().Window.Maximize()
        $driver.Navigate().GoToUrl($Global:testURL)
    }

    It "Should open $Global:testURL" {
        $driver.Title | Should -Be 'Google'
    }

    Describe "Can handle cookie banner" {
    
        BeforeAll {
            $cookieBtn = $driver.FindElementByXPath('//*[@id="L2AGLb"]/div')
        }
    
        It "Can find the cookie warning" {
            $cookieBtn | Should -Not -BeNullOrEmpty
            $cookieBtn.Text | Should -Be 'Ich stimme zu'
        }

        It "Can accept the cookie warning" {
            $cookieBtn.Click()
        }
    }

    Describe "Can perform a search" {

        BeforeAll {
            $search = $driver.FindElementByName("q")
        }

        It "Can find the search input" {
            $search | Should -Not -BeNullOrEmpty
        }

        It "Can enter search term and submit" {
            $search.SendKeys("Selenium Pester Powershell")
            $search.Submit()
        }
    }

    AfterAll {
        $driver.Close()
        $driver.Quit()
    }
}
