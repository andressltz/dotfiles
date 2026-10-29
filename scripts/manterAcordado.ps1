$code = @"
[DllImport("kernel32.dll", CharSet = CharSet.Auto, SetLastError = true)]
public static extern uint SetThreadExecutionState(uint esFlags);
"@

$type = Add-Type -MemberDefinition $code -Name "SleepUtil" -Namespace "Win32" -PassThru

# Constantes para impedir suspensão do sistema e da tela (ES_CONTINUOUS | ES_SYSTEM_REQUIRED | ES_DISPLAY_REQUIRED)
$ES_CONTINUOUS = [uint32]0x80000000
$ES_DISPLAY_REQUIRED = [uint32]0x00000002
$ES_SYSTEM_REQUIRED = [uint32]0x00000001

# Ativa o modo de "Não Dormir"
$type::SetThreadExecutionState($ES_CONTINUOUS -bor $ES_SYSTEM_REQUIRED -bor $ES_DISPLAY_REQUIRED)

Write-Host "O Windows permanecera acordado ate que voce feche esta janela..." -ForegroundColor Green

# Mantém o script rodando
while ($true) { Start-Sleep -Seconds 60 }
