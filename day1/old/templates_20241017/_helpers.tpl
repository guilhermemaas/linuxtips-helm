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
limits  
  memory: {{ .resources.limits.memory }}
  cpu: {{ .resources.limits.cpu }}
{{- end }}
