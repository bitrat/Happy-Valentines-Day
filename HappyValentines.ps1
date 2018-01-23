# ------- HAPPY VALENTINES DAY -------
# Type in the Name of the Person you Love
# Displays a Random positive word, per letter, of that person's Name
# TO DO: Unmentionably Nice things to the Person you Love

# TO DO: Continuous colourful Scrolling 

#ps version 2
#$PSScriptRoot = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition


Function Colour{
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
       
        $CSVFileName = $Letter+" words.csv"
        $CSVColourFileName = "Colours.csv"
        $CSVFileToReadin = $PSScriptRoot+"\Wordslists\"+$CSVFileName
        $CSVColourFileToReadin = $PSScriptRoot+"\Colourlist\"+$CSVColourFileName

        # Read in positive wordlist - i.e. "O Words.csv" 
        # Get wordlist in current folder, starting with the selected letter
        try {
            $DelimitedWords = Get-Content -Path $CSVFileToReadin -ErrorAction Stop
        } catch { 
            $DelimitedWords = Get-Content -Path $PSScriptRoot"\Wordslists\AnyWords.csv"
        }        
        $SingleWord = $DelimitedWords.split(",")
        $SingleWord = $SingleWord.Trim()

        # Select a word to use randomly
        $RandomWord=Get-Random -InputObject $SingleWord


        # Select random Colour
        try {
            $DelimitedColours = Get-Content -Path $CSVColourFileToReadin -ErrorAction Stop
        } catch { 
            Write-Output "No Colours file found."
        }         
        $SingleColour = $DelimitedColours.split(",")
        $SingleColour = $SingleColour.Trim()
        #Write-Output "-------------------"
        $RandomColour=Get-Random -InputObject $SingleColour

        #Add spacing for the positive output words
        $WhiteSpace = $LetterIndex*2-2
        $Space = $RandomWord.Length
        $Space = $Space + $WhiteSpace
        $RandomWord = $RandomWord.PadLeft($Space)
        Start-Sleep -s 1.2

        # Output Colour Words
        Write-Output "-------------------" 
         Write-Host $WordWithSpaces -ForegroundColor $RandomColour -BackgroundColor DarkBlue
        Write-Output "-------------------"
        Write-Host $RandomWord -ForegroundColor $RandomColour -BackgroundColor DarkBlue

        Write-Output "-  -  -  -  -  -  -"
        Write-Output "-------------------"

        Start-Sleep -s 1.2

    } 

 }

# Call Function - executes once (Testing purposes)
do{
    $StatusGood = $true
    Try {

        # Colour -Name "Name Of Person you Love"

        # Loops once
        Colour 
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

