@echo off
:: Impedir que o monitor desligue (0 = Nunca)
powercfg /change monitor-timeout-ac 0
powercfg /change monitor-timeout-dc 0

:: Impedir que o computador entre em suspensão (0 = Nunca)
powercfg /change standby-timeout-ac 0
powercfg /change standby-timeout-dc 0

:: Impedir que o computador hiberne (0 = Nunca)
powercfg /change hibernate-timeout-ac 0
powercfg /change hibernate-timeout-dc 0

:: Aplicar o plano de Alto Desempenho (Opcional, para garantir máxima performance)
powercfg /setactive SCHEME_MIN

echo Configuracoes de economia de energia desativadas com sucesso!
pause
