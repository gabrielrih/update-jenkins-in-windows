# README #
Versão 1.0

### No que consiste este respositório? ###

* Consiste em um script PowerShell utilizado para atualização automática do Jenkins.

### Como configurar? ###

* É importante configurar corretamente as variáveis "Configs" do script. Ali deve ser especificado qual é o diretório onde está instalado o Jenkins, qual é o nome da tarefa agendada que executa o Jenkins, etc.
* Para o script funcionar é necessário que tenha uma Tarefa Agendada no Windows que execute o Jenkins. Isso é necessário pois o script tentará parar esta tarefa e posteriormente iniciar novamente.
* Para testar, basta executar o script como administrador via PowerShell.
* Para que isso seja executado periodicamente temos que criar uma Tarefa Agendada no Windows para rodar este script.

### Em caso de falha? ###

* Em caso de falha na execução do script, podemos executá-lo manualmente para tentar identificar o problema.
* Caso a falha seja no Jenkins, um novo recurso da versão que "quebrou" alguma job que tínhamos por exemplo, podemos voltar a versão anterior. Para isso, ver diretório "backup" no caminho de instalação do Jenkins.
