Set-Location -Path "$PSScriptRoot\.."

If(-Not (Test-Path -Path "libs")){
	New-Item -ItemType Directory -Path libs
}

If(-Not (Test-Path -Path "libs\LibStub")){
	New-Item -ItemType SymbolicLink -Path "libs" -Name LibStub -Value ..\LibStub
} ElseIf(-Not (((Get-Item -Path "libs\LibStub").Attributes.ToString()) -Match "ReparsePoint")){
	Remove-Item -Path "libs\LibStub"
	New-Item -ItemType SymbolicLink -Path "libs" -Name LibStub -Value ..\LibStub
}

If(-Not (Test-Path -Path "libs\CallbackHandler-1.0")){
	New-Item -ItemType SymbolicLink -Path "libs" -Name CallbackHandler-1.0 -Value ..\CallbackHandler-1.0
} ElseIf(-Not (((Get-Item -Path "libs\CallbackHandler-1.0").Attributes.ToString()) -Match "ReparsePoint")){
	Remove-Item -Path "libs\CallbackHandler-1.0"
	New-Item -ItemType SymbolicLink -Path "libs" -Name CallbackHandler-1.0 -Value ..\CallbackHandler-1.0
}

If(-Not (Test-Path -Path "libs\LibResInfo-1.0")){
	New-Item -ItemType SymbolicLink -Path "libs" -Name LibResInfo-1.0 -Value ..\LibResInfo-1.0
} ElseIf(-Not (((Get-Item -Path "libs\LibResInfo-1.0").Attributes.ToString()) -Match "ReparsePoint")){
	Remove-Item -Path "libs\LibResInfo-1.0"
	New-Item -ItemType SymbolicLink -Path "libs" -Name LibResInfo-1.0 -Value ..\LibResInfo-1.0
}
