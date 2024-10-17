{{/*
Criar as nossas tags
*/}}
{{- define "app.labels" -}}
app: {{ .labels.app | quote }}
environment: {{ .labels.environment | quote }}
inLive: {{ .labels.inLive | quote }}
{{- end }}

{{/*
Definir os limites de recursos
*/}}
{{- define "app.resources" -}}
requests:
  memory: {{ .resources.requests.memory }}
  cpu: {{ .resources.requests.cpu }}
limits:  
  memory: {{ .resources.limits.memory }}
  cpu: {{ .resources.limits.cpu }}
{{- end }}

{{/*
Definir as portas dos containers
*/}}
{{- define "app.ports" -}}
{{ range .ports }}
- containerPort: {{ .port }}
{{- end }}
{{- end }}

{{/*
Definir os nossos configmaps de Database
*/}}
{{- define "database.configmap" -}}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .component }}-db-config
data:
  app-config.yaml: |
    {{- toYaml .config | nindent 4 }}
{{- end }}

{{/*
Definir os nossos configmaps de Observabilidade
*/}}
{{- define "observability.configmap" -}}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .component }}-observability-config
data:
  app-config.json: |
    {{ toJson .config }}
{{- end }}
