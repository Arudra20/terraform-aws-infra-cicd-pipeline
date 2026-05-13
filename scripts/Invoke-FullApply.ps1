param(
    [Parameter(Mandatory = $true)]
    [ValidateSet("dev", "stage", "prod")]
    [string]$Environment,

    [switch]$AutoApprove
)

$layers = @(
    "01-network",
    "02-registry",
    "03-cluster",
    "04-node-groups",
    "05-irsa",
    "06-addons",
    "07-apps"
)

foreach ($layer in $layers) {
    Write-Host "Applying layer: $layer" -ForegroundColor Yellow

    if ($AutoApprove) {
        & "$PSScriptRoot\Invoke-TerraformLayer.ps1" -Environment $Environment -Layer $layer -Action apply -AutoApprove
    }
    else {
        & "$PSScriptRoot\Invoke-TerraformLayer.ps1" -Environment $Environment -Layer $layer -Action apply
    }
}
