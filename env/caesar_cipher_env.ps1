# caesar_cipher: Released to Public Domain.
#
# Usage:
#   .\env\caesar_cipher_env.ps1 local
#   .\env\caesar_cipher_env.ps1 gate -DisableZig
#
# Presets keep build defaults in environment variables that batch scripts can reuse.

[CmdletBinding()]
param(
   [Parameter(Position = 0)]
   [string] $Preset = "local",

   [switch] $DisableZig,
   [string] $ZigRoot,
   [string] $ZigTarget = "x86_64-windows-gnu",
   [string] $ZigLibDir,

   [switch] $Clear,
   [switch] $EmitCmd,
   [switch] $Quiet
)

Set-StrictMode -Version 2.0

$knownVars = @(
   "HBCAESAR_CIPHER_ZIG_ENABLE",
   "HB_ZIG_ROOT",
   "HB_ZIG_TARGET",
   "HB_ZIG_LIBDIR"
)

$settings = [ordered] @{}

function Add-HBEnvSetting {
   param(
      [Parameter(Mandatory = $true)]
      [string] $Name,
      [AllowNull()]
      [string] $Value
   )

   if ($null -eq $Value) {
      $Value = ""
   }

   $script:settings[$Name] = $Value
}

function Add-HBEnvClear {
   param(
      [Parameter(Mandatory = $true)]
      [string[]] $Names
   )

   foreach ($name in $Names) {
      Add-HBEnvSetting -Name $name -Value ""
   }
}

function ConvertTo-CmdSetLine {
   param(
      [Parameter(Mandatory = $true)]
      [string] $Name,
      [AllowNull()]
      [string] $Value
   )

   $escapedValue = if ($null -eq $Value) { "" } else { $Value.Replace('"', '\"') }
   return 'set "' + $Name + '=' + $escapedValue + '"'
}

if ($Clear) {
   Add-HBEnvClear -Names $knownVars
} else {
   $presetName = $Preset.Trim().ToLowerInvariant()
   $knownPresets = @("local", "default", "gate")

   if ($presetName -notin $knownPresets) {
      throw "Unknown caesar_cipher environment preset '$Preset'. Use local, default, or gate."
   }

   if (-not $PSBoundParameters.ContainsKey("ZigRoot")) {
      $ZigRoot = "C:\GitHub\naldodj-harbour-core"
   }
   if (-not $PSBoundParameters.ContainsKey("ZigLibDir")) {
      $ZigLibDir = Join-Path $ZigRoot "lib\win\mingw64"
   }

   Add-HBEnvSetting -Name "HBCAESAR_CIPHER_ZIG_ENABLE" -Value $(if ($DisableZig) { "0" } else { "1" })
   Add-HBEnvSetting -Name "HB_ZIG_ROOT" -Value $ZigRoot
   Add-HBEnvSetting -Name "HB_ZIG_TARGET" -Value $ZigTarget
   Add-HBEnvSetting -Name "HB_ZIG_LIBDIR" -Value $ZigLibDir
}

if ($EmitCmd) {
   foreach ($entry in $settings.GetEnumerator()) {
      ConvertTo-CmdSetLine -Name $entry.Key -Value $entry.Value
   }
   exit 0
}

foreach ($entry in $settings.GetEnumerator()) {
   if ([string]::IsNullOrEmpty($entry.Value)) {
      Remove-Item -Path ("Env:" + $entry.Key) -ErrorAction SilentlyContinue
   } else {
      Set-Item -Path ("Env:" + $entry.Key) -Value $entry.Value
   }
}

if (-not $Quiet) {
   Write-Host "[caesar_cipher] Environment preset: $Preset"
   foreach ($entry in $settings.GetEnumerator()) {
      $value = if ([string]::IsNullOrEmpty($entry.Value)) { "(cleared)" } else { $entry.Value }
      Write-Host ("[caesar_cipher] {0}={1}" -f $entry.Key, $value)
   }
}
