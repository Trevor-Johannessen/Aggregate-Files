#TODO 
# - CHECK IF FILE ALREADY COPIED IS NEWER/OLDER THAN PREVIOUS
# - IMPLEMENT VERBOSE FLAG TO PRINT OUTPUT

$cmpFiles = Get-ChildItem -Path "Out" -File
$srcFiles = Get-ChildItem -Recurse -Path "Test" -File
foreach($dir in $srcFiles){
    foreach($file in $dir){
        $copy = $cmpFiles | Where-Object -Property "Name" -EQ $file.name
        if($copy.LastWriteTime -lt $file.LastWriteTime){
            Write-Output $file.PSPath
            Copy-Item -Path "$($file.PSPath)" -Destination "Out\\$($file.name)"
        }
    }
}
