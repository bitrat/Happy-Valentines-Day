# ------- HAPPY VALENTINES DAY -------
# Type in the Name of the Person you Love
# Displays a Random positive word, per letter, of that person's Name
# TO DO: Unmentionably Nice things to the Person you Love

# To DO: Create the positive word files (for alphabet characters)
# TO DO: Fail Positive - Any input will generate positive words (i.e. ' or -)
# TO DO: Continuous colourful Scrolling 

#ps version 2
#$PSScriptRoot = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition


Function Color{
    Param(
        [Parameter(Mandatory=$true)][string]$Name,
        [int]$LetterIndex=0
    )


    # Display the Name - plain
    Write-Output "-  -  -  -  -  -  -"
    Write-Output "-------------------"
    $Name.ToUpper()
    Write-Output "-------------------"
    Write-Output "-  -  -  -  -  -  -"

    # Extract Letters of the word 
    $Letters = $Name.ToCharArray()
    #$Letters
    #Write-Output "-------------------"

    Foreach ($Letter in $Letters){
    
        $LetterIndex += 1
        #$LetterIndex
        $WordWithSpaces +=$Letter + " "
        Write-Output "-------------------" 
        $WordWithSpaces
        Write-Output "-------------------"

        # TO DO: Create the filename to get the wordlist file, dynamically        
        $CSVFileName = $Letter+" words.csv"
        $CSVFileToReadin = $PSScriptRoot+"\Wordslists\"+$CSVFileName

        # Read in positive wordlist - i.e. "O Words.csv" 
        # Get wordlist in current folder, starting with the selected letter
        try {
            $DelimitedWords = Get-Content -Path $CSVFileToReadin -ErrorAction Stop
        } catch { 
            #TO DO: Create a catch-all word list
            $DelimitedWords = Get-Content -Path $PSScriptRoot"\Wordslists\AnyWords.csv"
        }
               

        $SingleWord = $DelimitedWords.split(",")
        $SingleWord = $SingleWord.Trim()
        #Write-Output "-------------------"

        # Select a word to use randomly
        $RandomWord=Get-Random -InputObject $SingleWord
        #$RandomWord
        # TO DO: Select random Color
        # TO DO: Remove hardcoding
        #$LetterIndex
        #TO DO:  Allow for More than 5 letter Names
        $WhiteSpace = $LetterIndex*2-2
        $Space = $RandomWord.Length
        $Space = $Space + $WhiteSpace
        $RandomWord = $RandomWord.PadLeft($Space)
        Start-Sleep -s 1.2
        $RandomWord

        Write-Output "-  -  -  -  -  -  -"
        Write-Output "-------------------"

        Start-Sleep -s 1.2

    } 

 }

# Call Function - executes once (Testing purposes)
do{
    $StatusGood = $true
    Try {
        # Continuous Looping
        # Color -Name "Name Of Person you Love"

        # Loops once
        Color 
    } Catch { 
        $StatusGood = $false 
        Write-Output "----------------------------------------------------"
        Write-Output "ERROR - Please supply the Name of the Person you Love"
        Write-Output "----------------------------------------------------"
        # Start Script again
        Set-Location -Path $PSScriptRoot
        .\HappyValentines.ps1
    }
} while ($StatusGood)

