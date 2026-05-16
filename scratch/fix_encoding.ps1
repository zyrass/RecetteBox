$files = Get-ChildItem -Path "docs", "README.md" -Recurse -Include "*.md"
foreach ($file in $files) {
    $content = [System.IO.File]::ReadAllText($file.FullName)
    [System.IO.File]::WriteAllText($file.FullName, $content, (New-Object System.Text.UTF8Encoding($false)))
}
