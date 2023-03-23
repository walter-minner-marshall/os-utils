# Set the directory where the config files are located
$rootDirectory = "C:\Dev\G1\g1-svc-micro"

$findHostnames = @("Data Source=USHGNDBWP010,4070", "Data Source=LSNRGNP111,4070") # Change this to an array of hostnames to find
$newHostname = "Data Source=USHGNDBWD020.stg-tfayd.com\\I0007DS01,4070" # Change this to the hostname to replace with

# Get all the config files in the directory and its subdirectories
$configFiles = Get-ChildItem -Path $rootDirectory -Recurse -Include "*.config", "*.json"

# Loop through each config file and replace the old hostname with the new hostname
foreach ($file in $configFiles) {
    # Get the content of the file
    $content = Get-Content $file.FullName

    foreach ($oldHostname in $findHostnames) {
        if ([string]::IsNullOrEmpty($hostname)) { continue }

        # Loop through each line of the content
        for ($i = 0; $i -lt $content.Length; $i++) {
            $line = $content[$i]

            # Check if the line contains the old hostname and is not null or empty
            if ($line -match $oldHostname -and !([string]::IsNullOrWhiteSpace($line))) {

                # Replace the old hostname with the new hostname and print out each occurrence
                $newLine = $line -replace $oldHostname, $newHostname
                if ($newLine -ne $line) {
                    $content[$i] = $newLine
                }
            }
        }

        # Write the updated content back to the file only if it has changed
        $newContent = $content | Out-String
        if ($newContent -ne (Get-Content $file.FullName | Out-String)) {
            Set-Content -Path $file.FullName -Value $newContent -Force
        }
    }
}

# Output a message when the script has completed
Write-Host "Hostnames replaced in all config files."