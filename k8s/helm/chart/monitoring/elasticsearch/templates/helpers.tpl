{{/*
Generate certificates when the secret doesn't exist
*/}}
{{- define "elasticsearch.gen-certs" -}}
{{- $certs := lookup "v1" "Secret" .Release.Namespace ( printf "%s-certs" (include "elasticsearch.uname" . ) ) -}}
{{- if $certs -}}
tls.crt: {{ index $certs.data "tls.crt" }}
tls.key: {{ index $certs.data "tls.key" }}
ca.crt: {{ index $certs.data "ca.crt" }}
{{- else -}}
{{- $altNames := list ( include "elasticsearch.masterService" . ) ( printf "%s.%s" (include "elasticsearch.masterService" .) .Release.Namespace ) ( printf "%s.%s.svc" (include "elasticsearch.masterService" .) .Release.Namespace ) -}}
{{- $ca := genCA "elasticsearch-ca" 365 -}}
{{- $cert := genSignedCert ( include "elasticsearch.masterService" . ) nil $altNames 365 $ca -}}
tls.crt: {{ $cert.Cert | toString | b64enc }}
tls.key: {{ $cert.Key | toString | b64enc }}
ca.crt: {{ $ca.Cert | toString | b64enc }}
{{- end -}}
{{- end -}}
