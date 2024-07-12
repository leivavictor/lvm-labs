
Add-Type -AssemblyName System.Net.Http

$URL = "https://exampleapp.com"
$URL_HOST = "exampleresourcename"

$client = New-Object System.Net.Http.HttpClient
$response = $client.SendAsync((New-Object System.Net.Http.HttpRequestMessage -ArgumentList 'HEAD', $URL)).Result

if ($response -eq 'OK'){

    Write-Information -Message "$URL is healthy"

}else{

    Write-Warning -Message "$URL may be down, performing checks"

    for ($i = 0; $i -lt 10; $i++) {
        
        Start-Sleep -Seconds 30

        $response = $client.SendAsync((New-Object System.Net.Http.HttpRequestMessage -ArgumentList 'HEAD', $URL)).Result

        if($response -ne 'OK'){

            $SiteHealthy = $false
        }
        
    }

    if ($SiteHealthy -eq $false){

        Write-Error -Message "$URL is down. Review the status in Azure Resource $URL_HOST"

    }
}
