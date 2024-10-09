# Define the path to the _posts directory
$postsDir = "G:\projects\autocrossblog\autocrossblog.github.io\_posts\"

# Get all markdown files in the _posts directory
$files = Get-ChildItem -Path $postsDir -Filter *.md

# Loop through each file
foreach ($file in $files) {
    # Read the content of the file
    $content = Get-Content -Path $file.FullName
    
    # Flag to track if we are in the YAML front matter
    $inFrontMatter = $false
    $categoriesFound = $false
    $newContent = @()
    
    # Iterate through each line of the file
    foreach ($line in $content) {
        # Check for the start of the front matter
        if ($line -eq "---") {
            $inFrontMatter = -not $inFrontMatter
        }
        
        # If we're inside the front matter, check for the categories tag with optional spaces
        if ($inFrontMatter -and $line -match "^\s*categories:\s*\[.*\]") {
            # Extract the categories part from the line
            $categoriesLine = $line -replace "\s*categories:\s*\[(.*)\]", '$1'
            
            # Split categories by comma, trim spaces, and convert to lowercase
            $categoriesLowercase = $categoriesLine -split "," | ForEach-Object { $_.Trim() -replace "\s", "" } | ForEach-Object { $_.ToLower() }
            
            # Join the categories back into a line
            $newCategoriesLine = "categories: [ " + ($categoriesLowercase -join ", ") + " ]"
            
            # Replace the line with the new lowercase categories
            $newContent += $newCategoriesLine
            $categoriesFound = $true
        } else {
            # If the line isn't the categories line, just add it to the new content
            $newContent += $line
        }
    }
    
    # If categories were found and changed, overwrite the file with the new content
    if ($categoriesFound) {
        $newContent | Set-Content -Path $file.FullName
        Write-Host "Updated categories in $($file.FullName)"
    }
}
