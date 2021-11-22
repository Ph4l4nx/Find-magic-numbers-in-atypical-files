#add extensions here to ignore (i.e whitelist)
$ignore_extensions = '.exe','.dll'

#grab all items in the current directory
$mylisting = Get-ItemProperty *
Write-Host("Number of files/folders:")$mylisting.count
$count_suspect = 0
for($i=0;$i -lt $mylisting.count; $i++)
{
    #for each item in the listing: ensure the item is not a directory and not an ignored extension
    if( (Test-Path $mylisting[$i] -PathType Leaf) -and ($mylisting[$i].extension -notin $ignore_extensions) )
    { 
        $magicBytes = '{0:X2}' -f (Get-Content $myfiles[$i] -Encoding Byte -ReadCount 4)
        if($magicBytes -eq '4D 5A 90 00')
        {
            write-host("Found atypical file:")$myfiles[$i]
            $count_suspect++
        }
    }
}
Write-Host("Number of suspect files found:")$count_suspect



