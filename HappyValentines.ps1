# ------- HAPPY VALENTINES DAY 2018 -------
# Type in the Name of the Person you Love
# Displays a Random positive word, per letter, of that person's Name
# TO DO: Unmentionably Nice things to the Person you Love

Function Colour{
    Param(
        [Parameter(Mandatory=$true)][string]$Name,
        [int]$LetterIndex=0,
        [string]$ColourUsed="white"
    )

while ($Name){
    # Display the Name - plain
    Write-Output "`n-  -  -  -  -  -  - -  -  -  -  -  -  "
    Write-Output "--------------------------------------"

    # Normal Message to Exit Loop
    #$StartMessage = " Control + C to stop this Love Loop"
    #Write-Host $StartMessage -ForegroundColor red -BackgroundColor DarkBlue

    # Bunny Holding Sign Message to Exit Loop
    $StartMessage = "`n  |￣￣￣￣￣￣￣￣|`n  |    Press    |`n  | Control + C |`n  |   to stop   |`n  |    this     |`n  |  Love Loop  |`n  |_____________|`n  (\__/) ||`n  (•ㅅ•) ||`n  / 　 づ"
    Write-Host $StartMessage -ForegroundColor red -BackgroundColor DarkBlue
    Write-Output "-  -  -  -  -  -  - -  -  -  -  -  -  "
    Write-Output "--------------------------------------"
    $Name.ToUpper()
    Write-Output "--------------------------------------"
    Write-Output "-  -  -  -  -  -  - -  -  -  -  -  -  "

    # Extract Letters of the word 
    $Letters = $Name.ToCharArray()
    #$Letters
    #Write-Output "--------------------------------------"

    #Reset Values for next iteration of the Loop
    $LetterIndex = 0
    $WordWithSpaces = ""
    $RandomWord = ""
    $WhiteSpace = 1
    $Space = 1
    $RandomWord = ""

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

        Do {
            $RandomColour=Get-Random -InputObject $SingleColour
            #Write-Output "--------------------------------------"
            #Write-Output $RandomColour
            #Write-Output "--------------------------------------"
        }
        Until ($RandomColour -ne $ColourUsed)
        $ColourUsed = $RandomColour

        #Write-Output "--------------------------------------"
        #Write-Output $RandomColour $ColourUsed
        #Write-Output "--------------------------------------"
        
        #Add spacing for the positive output words
        $WhiteSpace = $LetterIndex*2-2
        $Space = $RandomWord.Length
        $Space = $Space + $WhiteSpace
        $RandomWord = $RandomWord.PadLeft($Space)
        Start-Sleep -s 1

        # Output Colour Words
        Write-Output "--------------------------------------" 
        Write-Host $WordWithSpaces -ForegroundColor $RandomColour -BackgroundColor DarkBlue
        Write-Output "--------------------------------------"
        Write-Host $RandomWord -ForegroundColor $RandomColour -BackgroundColor DarkBlue

        Write-Output "-  -  -  -  -  -  - -  -  -  -  -  -  "
        Write-Output "--------------------------------------"

        Start-Sleep -s 1.2
    } 
  }

 }

# Call Function - executes once (Testing purposes)
do{
    $StatusGood = $true
    Try {

        # TESTING - Below Line will continuously loop
        # Test Value XXXX
        #Colour -Name "XXXX"

        # Continous Looping of the Person's name that is input
        Colour 

    } Catch { 
        $StatusGood = $false 
        Write-Output "------------------------------------------------------"
        Write-Output "ERROR - Please supply the Name of the Person you Love"
        Write-Output "------------------------------------------------------"
        # Start Script again
        Set-Location -Path $PSScriptRoot
        .\HappyValentines.ps1
    }
} while ($StatusGood)

