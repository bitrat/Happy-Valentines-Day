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
    Write-Host "-------------------"
    $Name
    Write-Host "-------------------"

    # Extract Letters of the word 
    $Letters = $Name.ToCharArray()
    #$Letters
    #Write-Host "-------------------"

    # TO DO: Display Name with Spaces inbetween
    Foreach ($Letter in $Letters){
    
        $LetterIndex += 1
        #$LetterIndex
        $WordWithSpaces +=$Letter + " "
        Write-Host "-------------------" 
        $WordWithSpaces
        Write-Host "-------------------"

        # TO DO: Create the filename to get the wordlist file, dynamically        
        $CSVFileName = $Letter+" words.csv"
        $CSVFileToReadin = $PSScriptRoot+"\"+$CSVFileName

        # Read in positive wordlist - i.e. "O Words.csv" 
        # Get wordlist in current folder, starting with the selected letter
        try {
            $DelimitedWords = Get-Content -Path $CSVFileToReadin -ErrorAction Stop
        } catch { 
            #TO DO: Create a catch-all word list
            $DelimitedWords = Get-Content -Path $PSScriptRoot"\A words.csv"
        }
               

        $SingleWord = $DelimitedWords.split(",")
        $SingleWord = $SingleWord.Replace(" ","")
        #Write-Host "-------------------"

        # Select a word to use randomly
        $RandomWord=Get-Random -InputObject $SingleWord
        #$RandomWord
        # TO DO: Select random Color
        # TO DO: Remove hardcoding
        #$LetterIndex
        Switch ($LetterIndex) {
            #TO DO: Allow for More than 5 letter Names
            1 {$RandomWord}
            2 {$RandomWord = "   "+$RandomWord
                $RandomWord}
            3 {$RandomWord = "    "+$RandomWord
                $RandomWord}
            4 {$RandomWord = "      "+$RandomWord
                $RandomWord}
            5 {$RandomWord = "        "+$RandomWord
                $RandomWord }
        }

        # Display Letters on new line
        #$JuxtaposWord = $RandomWord.ToCharArray()
        # TO DO: Add offset to each letter, based on Index


    } 

 }

# Call Function - executes once (Testing purposes)
Color