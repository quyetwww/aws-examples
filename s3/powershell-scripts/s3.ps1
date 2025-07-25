Import-Module AWS.Tools.S3

$region = "ap-southeast-1"

$bucketName = Read-Host -Prompt "Enter the S3 bucket name"

Write-Host "Listing objects in bucket '$bucketName' in region '$region'..."

New-S3Bucket -BucketName $bucketName -Region $region

function BucketExists {
    $bucket = Get-S3Bucket -BucketName $bucketName -ErrorAction SilentlyContinue
    return $null -ne $bucket
}

if(-not (BucketExists)) {
    Write-Host "Bucket '$bucketName' does not exist. Creating bucket..."
    New-S3Bucket -BucketName $bucketName -Region $region
} else {
    Write-Host "Bucket '$bucketName' already exists."
}

# Create a new file in the bucket

$fileName = "example.txt"
$fileContent = "This is an example file."

Set-Content -Path $fileName -Value $fileContent
Write-Host "Uploading file '$fileName' to bucket '$bucketName'..."
Write-S3Object -BucketName $bucketName -File $fileName -Key $fileName -Region $region