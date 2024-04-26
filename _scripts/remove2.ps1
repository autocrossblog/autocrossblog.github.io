$directoryPath = ".\_posts\*"

# Get all .html and .md files
$files = Get-ChildItem -Path $directoryPath -Include "*.html", "*.md" -Recurse

foreach ($file in $files) {
    Write-Host "Processing file: $($file.FullName)"
    $content = Get-Content $file.FullName -Raw

    # Regex pattern to match YAML front matter
    $yamlPattern = "(?s)^\s*---\s*(.+?)\s*---"

    # Check if file contains YAML front matter
    if ($content -match $yamlPattern) {
        $yaml = $matches[1]
        Write-Host "Found YAML front matter."

        # Regex to remove lines starting with - "/Blog/ or - "/Video
        $yaml = $yaml -replace "\n\s*-\s*""?/(Blog|Video|tabid)/[^""\n]*""?", ""
        Write-Host "Removed specific lines from YAML."

        # Replace old YAML with new YAML
        $newContent = $content -replace $yamlPattern, "---`n$yaml`n---"

        # Write the new content back to the file
        Set-Content -Path $file.FullName -Value $newContent
        Write-Host "Updated file: $($file.FullName)"
    } else {
        Write-Host "No YAML front matter found."
    }
}
