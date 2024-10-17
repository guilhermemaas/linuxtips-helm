### Adicionar um repo Helm:
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

### Instalar um repo Helm:
helm install [RELEASE_NAME] prometheus-community/prometheus

### Instalar um chart tendo o dir local:
helm install giropops-senhas ./

### Listar os charts instalados:
helm list

### Desinstalar um helm chart:
helm uninstall giropops-senhas
k port-forward svc/giropops-senhas-helm 5000:5000

### Fazer upgrade usando um values novo, ou então com novas alterações
helm upgrade giropops-senhas ./

### helm upgrade --debug --dry-run
O comando helm upgrade --debug --dry-run é utilizado para simular uma atualização de uma release do Helm sem realmente aplicar as mudanças ao cluster Kubernetes. Vamos detalhar o que cada parte desse comando faz:

helm upgrade: Este é o comando usado para atualizar uma release existente. Você especifica o nome da release e o chart (ou caminho para o chart) com o qual deseja atualizar.

--debug: Esta opção fornece informações adicionais para debug, ou seja, mais detalhes sobre o que está acontecendo internamente durante a execução do comando. Ele imprime informações adicionais sobre o processo de renderização dos templates, incluindo as etapas intermediárias e o output final dos templates.

--dry-run: Esta opção simula a execução do comando sem realmente realizar quaisquer mudanças no cluster. Ele renderiza as templates do Helm e mostra o que seria atualizado ou modificado, sem efetuar nenhuma alteração real. Isso permite revisar as mudanças planejadas antes de aplicá-las.

Combinar --debug e --dry-run é muito útil para testar alterações e verificar como os templates serão renderizados e quais mudanças serão feitas, sem afetar o estado atual das aplicações no cluster. Isso é especialmente importante para identificar e corrigir erros potenciais antes de realizar uma atualização real.

### Plugin para ver a diff entre releases ou --debug --dry-run
https://github.com/databus23/helm-diff

### Ver a saída do comando do helm em formato yaml (Os manifestos):
helm install --dry-run giropops-senhas ./

### Mapear um config YAML -> Json
{{- range $component, $config := .Values.observability }}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $component }}-observability-config
data:
  app-config.json: |
    {{ toJson $config }}
{{- end }}

### Lint - Testa um diretório para ver se é um path válido para um helm chart
helm lint path

### Renderizar template (yaml)
helm template path


### Criar repositório remoto de Helm Charts (helm package)
### Criar o index na raiz do repo:
helm repo index --url https://github.com/guilhermemaas/linuxtips-helm-chart .

### Tree
.
├── charts
│   └── giropops-senhas
│       ├── charts
│       ├── Chart.yaml
│       ├── templates
│       │   ├── database-configmap.yaml
│       │   ├── giropops-senhas-deployments.yaml
│       │   ├── giropops-senhas-services.yaml
│       │   ├── _helpers.tpl
│       │   └── observability-configmap.yaml
│       └── values.yaml
├── giropops-senhas-0.1.0.tgz
└── index.yaml

### Adicionar o helm repo criado no git
helm repo add giropops-gmaas https://guilhermemaas.github.io/linuxtips-helm-chart/

### Buscar pelos repos instalados
helm search repo giro

### Instalar:
helm install giropops-gmaas giropops-gmaas/giropops-senhas