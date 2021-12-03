# Atualização automática do Jenkins.
# Este processo realiza o download da versão mais atual do Jenkins, faz um backup do atual e substitui o novo arquivo WAR.
# Em caso de erro, é possível voltar o arquivo WAR antigo.
#
# Referências de apoio:
# 	https://wiki.jenkins.io/display/jenkins/automated+upgrade
#
# Richter, Gabriel <gabrielrih@gmail.com>
# 28-07-2021
#

# Configs
$jenkinsHome="C:\Program Files\Jenkins" # Local de instalação do Jenkins
$jenkinsBackup="C:\Program Files\Jenkins\backups" # Local dos arquivos de backup do Jenkins
$jenkinsURL="http://mirrors.jenkins-ci.org/war/latest/jenkins.war" # Link da nova versão
$jenkinsNewWar="jenkins.latest.war" # Nome do arquivo que será baixado
$jenkinsCurrentWar="jenkins.war" # Nome do arquivo atualmente rodando
$schedulerTaskJenkins="Jenkins Starting Up" # Nome da tarefa agendada do Windows que inicia o Jenkins no Start Up da máquina

# Backup config
$DateTimeFormatted = Get-Date -Format "yyyyMMdd.HHmmss"
$jenkinsBakWar = $jenkinsCurrentWar + "." + $DateTimeFormatted + ".bak" # Nome do arquivo de backup, exemplo, jenkins.war.20210817.161309.bak

# Variáveis auxiliares (Full filename)
$FullFileNameJenkinsNew = $jenkinsHome + '\' + $jenkinsNewWar
$FullFileNameJenkinsCurrent = $jenkinsHome + '\' + $jenkinsCurrentWar
$FullFileNameJenkinsBak = $jenkinsBackup + '\' + $jenkinsBakWar

# Baixa o arquivo
echo "(+) Downloading latest version..."
$Object = New-Object System.Net.WebClient
$Object.DownloadFile($jenkinsURL, $FullFileNameJenkinsNew)
#Invoke-WebRequest $jenkinsURL -O $FullFileNameJenkinsNew # Esta cara é uma alternativa de download, porém é mais lenta

# Para a tarefa agendada
Echo "(+) Stopping Jenkins..."
Stop-ScheduledTask -TaskName "$schedulerTaskJenkins" # Para a tarefa agendada que roda o Jenkins
sleep 5 # zzz

# Realiza o backup do arquivo
Echo "(+) Backup Jenkins war"
New-Item -ItemType Directory -Force -Path $jenkinsBackup | Out-Null # Cria diretório de backup caso não exista
copy "$FullFileNameJenkinsCurrent" "$FullFileNameJenkinsBak"
sleep 5 # zzz

# Aplica nova versão
Echo "(+) Apply new version..."
del "$FullFileNameJenkinsCurrent"
move "$FullFileNameJenkinsNew" "$FullFileNameJenkinsCurrent"
sleep 5 # zzz

# Inicia tarefa agendada novamente
Echo "(+) Starting new upgraded Jenkins..."
Start-ScheduledTask -TaskName "$schedulerTaskJenkins" # Inicia a tarefa agendada novamente
sleep 1 # zzz