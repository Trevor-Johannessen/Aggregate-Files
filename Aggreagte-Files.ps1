$In
$Out
if(!$In){ $In = $args[0]}
if(!$Out){$Out = $args[1]}


$cmpFiles = Get-ChildItem -Path $out -File
$srcFiles = Get-ChildItem -Recurse -Path $in -File
$fileTable = @{}
foreach($dir in $srcFiles){
    foreach($file in $dir){
        If(-not $fileTable.ContainsKey($file.Name)){
            $fileTable.Add($file.Name, @($file.PSPath, $file.LastWriteTime))
        }ElseIf($fileTable[$file.Name][1] -lt $file.LastWriteTime){
            Write-Output $file.PSPath
            $fileTable[$file.Name] = @($file.PSPath, $file.LastWriteTime)
        }
    }
}

foreach($file in $fileTable.keys){
    Write-Output "File = $($file)"
    $copy = $cmpFiles | Where-Object -Property "Name" -EQ $file
    if($copy.LastWriteTime -lt $fileTable[$file][1]){
        Copy-Item -Path $fileTable[$file][0] -Destination "$($out)\\$($file)"
    }
}
