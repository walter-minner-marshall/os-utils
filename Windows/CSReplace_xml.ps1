# Set the path to the folder containing the config files
$rootDirectory = "C:\Dev\G1\g1-main"

# Set the old and new hostnames
$findHostnames = @("USHGNDBWP010,4070", "LSNRGNP111,4070", "USHGNDBWD008\I0007DS01,4070") # Change this to an array of hostnames to find
$replaceHostname = "USHGNDBWD020.stg-tfayd.com\I0007DS01,4070" # Change this to the hostname to replace with

# Find all config files in subdirectories of the root directory
$configFiles = Get-ChildItem -Path $rootDirectory -Recurse -Include "*.config"

# Loop through each config file
foreach ($configFile in $configFiles) {

    # Load the config file as an XML document
    [xml]$xml = Get-Content $configFile.FullName -Raw

    # Find all connection strings in the XML document
    if ([string]::IsNullOrEmpty($xml.configuration.connectionStrings.add)){
        $connectionStrings = $xml.connectionStrings.add
    } else {
        $connectionStrings = $xml.configuration.connectionStrings.add
    }

    # Initialize a variable to track whether a connection string was replaced
    $connectionStringReplaced = $false

    # Loop through each connection string
    foreach ($connectionString in $connectionStrings) {
        # Get the current value of the connection string
        $currentConnectionString = $connectionString.connectionString

        # Check if the current value is null or empty
        if ([string]::IsNullOrEmpty($currentConnectionString)) {
            # Skip this connection string if it's null or empty
            continue
        }
        
        # Loop through each old hostname to find and replace
        foreach ($oldHostname in $findHostnames) {
            # Replace the old hostname with the new hostname
            $newConnectionString = $currentConnectionString.Replace($oldHostname, $replaceHostname)

            # Check if the connection string was updated
            if ($newConnectionString -ne $currentConnectionString) {
                # Update the connection string in the XML document
                $connectionString.connectionString = $newConnectionString

                # Set the variable to indicate that a connection string was replaced
                $connectionStringReplaced = $true
            }
        }
    }

    # Save the updated XML document to the config file if a connection string was replaced
    if ($connectionStringReplaced) {
        # Save the updated config file, preserving the file encoding and formatting
        $xmlWriter = New-Object System.Xml.XmlTextWriter($configFile.FullName, $null)
        $xmlWriter.Formatting = [System.Xml.Formatting]::Indented
        $xml.Save($xmlWriter)
        $xmlWriter.Close()
    }
}


Write-Host "Hostname replacement complete."
