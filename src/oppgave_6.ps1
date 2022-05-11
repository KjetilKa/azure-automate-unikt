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

function sumPoengKortstokk {
    [OutputType([int])]
    param (
        [object[]]
        $kortstokk
    )

    $poengKortstokk = 0

    foreach ($kort in $kortstokk) {
        $poengKortstokk += switch ($kort.value) {
            { $_ -cin @('J', 'Q', 'K') } { 10 }
            'A' { 11 }
            default { $kort.value }
        }
    }
    return $poengKortstokk
}

Write-Output "Poengsum: $(sumPoengKortstokk -kortstokk $kortstokk)"


$meg = $kortstokk[0..1]
$kortstokk = $kortstokk[2..($kortstokk.Count - 1)]

$magnus = $kortstokk[0..1]
$kortstokk = $kortstokk[2..($kortstokk.Count - 1)]

Write-Host "Meg: $(kortstokkTilStreng -kortstokk $meg)"
Write-Host "Magnus: $(kortstokkTilStreng -kortstokk $magnus)"
Write-Host "Kortstokk: $(kortstokkTilStreng -kortstokk $kortstokk)"
