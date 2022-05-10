$ErrorActionPreference = 'Stop'
$webRequest = Invoke-WebRequest -Uri "http://nav-deckofcards.herokuapp.com/shuffle"
$kortstokkJson = $webRequest.Content
$kortstokk = ConvertFrom-Json -InputObject $kortstokkJson

function kortstokkTilStreng  {
    [OutputType([string])]
    param (
        [object[]]
        $kortstokk
    )
    $streng = ""
    foreach ($kort in $kortstokk) {
        $streng = $streng + "$($kort.suit[0])" + "$($kort.value)" + ","
    }
    return $streng
}

Write-Output "Kortstokk: $(kortstokkTilStreng -kortstokk $kortstokk)"