### Create grafana using Helm with custom dashboards based on no longer suported https://s3-eu-west-1.amazonaws.com/coreos-charts/stable/

##### Add above repo to helm

`helm repo add coreos https://s3-eu-west-1.amazonaws.com/coreos-charts/stable/`


##### Create a config map to include custom dashboards. Those are build into the configmap file. 
##### In the future grafana 6 I will import dashboards from separate files. 
##### See bottom of this page for a way to convert dashboards from Grafana format into the configmap format.

`kubectl create -f cm-custom-dashboards.yaml -n monitoring`

##### cm-custom-dashboards.yaml with rpi-dashboard.json (it was originaly runningn from Raspberry Pi)

```
apiVersion: v1
kind: ConfigMap
metadata:
  name: custom-dashboards
data:
  rpi-dashboard.json: |-
    {
      "dashboard": {
        "__inputs": [
          {
            "name": "DS_PROMETHEUS",
            "label": "prometheus",
            "description": "",
            "type": "datasource",
            "pluginId": "prometheus",
            "pluginName": "Prometheus"
          },
          {
            "name": "VAR_NODE",
            "type": "constant",
            "label": "node",
            "value": ".*",
            "description": ""
          },
          {
            "name": "VAR_NAMESPACE",
            "type": "constant",
            "label": "namespace",
            "value": ".*",
            "description": ""
          }
        ],
        "annotations": {
          "list": [
            {
              "builtIn": 1,
              "datasource": "-- Grafana --",
              "enable": true,
              "hide": true,
              "iconColor": "rgba(0, 211, 255, 1)",
              "name": "Annotations & Alerts",
              "type": "dashboard"
            }
          ]
        },
        "editable": true,
        "gnetId": null,
        "graphTooltip": 0,
        "id": null,
        "iteration": 1556186097850,
        "links": [],
        "panels": [
          {
            "cacheTimeout": null,
            "colorBackground": false,
            "colorValue": false,
            "colors": [
              "#299c46",
              "rgba(237, 129, 40, 0.89)",
              "#d44a3a"
            ],
            "datasource": "${DS_PROMETHEUS}",
            "format": "none",
            "gauge": {
              "maxValue": 100,
              "minValue": 0,
              "show": false,
              "thresholdLabels": false,
              "thresholdMarkers": true
            },
            "gridPos": {
              "h": 5,
              "w": 4,
              "x": 0,
              "y": 0
            },
            "id": 8,
            "interval": null,
            "links": [],
            "mappingType": 1,
            "mappingTypes": [
              {
                "name": "value to text",
                "value": 1
              },
              {
                "name": "range to text",
                "value": 2
              }
            ],
            "maxDataPoints": 100,
            "nullPointMode": "connected",
            "nullText": null,
            "postfix": "",
            "postfixFontSize": "50%",
            "prefix": "",
            "prefixFontSize": "50%",
            "rangeMaps": [
              {
                "from": "null",
                "text": "N/A",
                "to": "null"
              }
            ],
            "sparkline": {
              "fillColor": "rgba(31, 118, 189, 0.18)",
              "full": false,
              "lineColor": "rgb(31, 120, 193)",
              "show": true
            },
            "tableColumn": "",
            "targets": [
              {
                "expr": "sum(kube_pod_status_phase{namespace=~\"$namespace\", phase=\"Running\"})",
                "format": "time_series",
                "interval": "",
                "intervalFactor": 1,
                "refId": "A"
              }
            ],
            "thresholds": "",
            "title": "Pods Running Current",
            "type": "singlestat",
            "valueFontSize": "200%",
            "valueMaps": [
              {
                "op": "=",
                "text": "N/A",
                "value": "null"
              }
            ],
            "valueName": "current"
          },
          {
            "cacheTimeout": null,
            "colorBackground": false,
            "colorValue": false,
            "colors": [
              "#299c46",
              "rgba(237, 129, 40, 0.89)",
              "#d44a3a"
            ],
            "datasource": "${DS_PROMETHEUS}",
            "format": "none",
            "gauge": {
              "maxValue": 100,
              "minValue": 0,
              "show": false,
              "thresholdLabels": false,
              "thresholdMarkers": true
            },
            "gridPos": {
              "h": 5,
              "w": 4,
              "x": 4,
              "y": 0
            },
            "id": 6,
            "interval": null,
            "links": [],
            "mappingType": 1,
            "mappingTypes": [
              {
                "name": "value to text",
                "value": 1
              },
              {
                "name": "range to text",
                "value": 2
              }
            ],
            "maxDataPoints": 100,
            "nullPointMode": "connected",
            "nullText": null,
            "postfix": "",
            "postfixFontSize": "50%",
            "prefix": "",
            "prefixFontSize": "50%",
            "rangeMaps": [
              {
                "from": "null",
                "text": "N/A",
                "to": "null"
              }
            ],
            "sparkline": {
              "fillColor": "rgba(31, 118, 189, 0.18)",
              "full": false,
              "lineColor": "rgb(31, 120, 193)",
              "show": true
            },
            "tableColumn": "",
            "targets": [
              {
                "expr": "sum(kube_pod_status_phase{namespace=~\"$namespace\", phase=\"Pending\"})",
                "format": "time_series",
                "interval": "",
                "intervalFactor": 1,
                "refId": "A"
              }
            ],
            "thresholds": "",
            "title": "Pods Pending Total",
            "type": "singlestat",
            "valueFontSize": "200%",
            "valueMaps": [
              {
                "op": "=",
                "text": "N/A",
                "value": "null"
              }
            ],
            "valueName": "total"
          },
          {
            "cacheTimeout": null,
            "colorBackground": true,
            "colorValue": false,
            "colors": [
              "rgb(32, 31, 36)",
              "rgba(237, 129, 40, 0.89)",
              "#d44a3a"
            ],
            "datasource": "${DS_PROMETHEUS}",
            "format": "none",
            "gauge": {
              "maxValue": 100,
              "minValue": 0,
              "show": false,
              "thresholdLabels": false,
              "thresholdMarkers": true
            },
            "gridPos": {
              "h": 5,
              "w": 4,
              "x": 8,
              "y": 0
            },
            "id": 10,
            "interval": null,
            "links": [],
            "mappingType": 1,
            "mappingTypes": [
              {
                "name": "value to text",
                "value": 1
              },
              {
                "name": "range to text",
                "value": 2
              }
            ],
            "maxDataPoints": 100,
            "nullPointMode": "connected",
            "nullText": null,
            "postfix": "",
            "postfixFontSize": "50%",
            "prefix": "",
            "prefixFontSize": "50%",
            "rangeMaps": [
              {
                "from": "null",
                "text": "N/A",
                "to": "null"
              }
            ],
            "sparkline": {
              "fillColor": "#82b5d8",
              "full": false,
              "lineColor": "#82b5d8",
              "show": true
            },
            "tableColumn": "",
            "targets": [
              {
                "expr": "sum(kube_pod_status_phase{namespace=~\"$namespace\", phase=\"Failed\"})",
                "format": "time_series",
                "intervalFactor": 1,
                "refId": "A"
              }
            ],
            "thresholds": "0.9,1",
            "title": "Pods Failed Total",
            "type": "singlestat",
            "valueFontSize": "200%",
            "valueMaps": [
              {
                "op": "=",
                "text": "N/A",
                "value": "null"
              }
            ],
            "valueName": "total"
          },
          {
            "cacheTimeout": null,
            "colorBackground": false,
            "colorValue": false,
            "colors": [
              "#299c46",
              "rgba(237, 129, 40, 0.89)",
              "#d44a3a"
            ],
            "datasource": "${DS_PROMETHEUS}",
            "format": "none",
            "gauge": {
              "maxValue": 100,
              "minValue": 0,
              "show": false,
              "thresholdLabels": false,
              "thresholdMarkers": true
            },
            "gridPos": {
              "h": 5,
              "w": 4,
              "x": 12,
              "y": 0
            },
            "id": 14,
            "interval": null,
            "links": [],
            "mappingType": 1,
            "mappingTypes": [
              {
                "name": "value to text",
                "value": 1
              },
              {
                "name": "range to text",
                "value": 2
              }
            ],
            "maxDataPoints": 100,
            "nullPointMode": "connected",
            "nullText": null,
            "postfix": "",
            "postfixFontSize": "50%",
            "prefix": "",
            "prefixFontSize": "50%",
            "rangeMaps": [
              {
                "from": "null",
                "text": "N/A",
                "to": "null"
              }
            ],
            "sparkline": {
              "fillColor": "rgba(31, 118, 189, 0.18)",
              "full": false,
              "lineColor": "rgb(31, 120, 193)",
              "show": true
            },
            "tableColumn": "",
            "targets": [
              {
                "expr": "sum(kube_pod_status_phase{namespace=~\"$namespace\", phase=\"Unknown\"})",
                "format": "time_series",
                "intervalFactor": 1,
                "refId": "A"
              }
            ],
            "thresholds": "",
            "title": "Pods Unknown Total",
            "type": "singlestat",
            "valueFontSize": "200%",
            "valueMaps": [
              {
                "op": "=",
                "text": "N/A",
                "value": "null"
              }
            ],
            "valueName": "total"
          },
          {
            "cacheTimeout": null,
            "colorBackground": false,
            "colorValue": false,
            "colors": [
              "#299c46",
              "rgba(237, 129, 40, 0.89)",
              "#d44a3a"
            ],
            "datasource": "${DS_PROMETHEUS}",
            "format": "none",
            "gauge": {
              "maxValue": 100,
              "minValue": 0,
              "show": false,
              "thresholdLabels": false,
              "thresholdMarkers": true
            },
            "gridPos": {
              "h": 5,
              "w": 4,
              "x": 16,
              "y": 0
            },
            "id": 12,
            "interval": null,
            "links": [],
            "mappingType": 1,
            "mappingTypes": [
              {
                "name": "value to text",
                "value": 1
              },
              {
                "name": "range to text",
                "value": 2
              }
            ],
            "maxDataPoints": 100,
            "nullPointMode": "connected",
            "nullText": null,
            "postfix": "",
            "postfixFontSize": "50%",
            "prefix": "",
            "prefixFontSize": "50%",
            "rangeMaps": [
              {
                "from": "null",
                "text": "N/A",
                "to": "null"
              }
            ],
            "sparkline": {
              "fillColor": "rgba(31, 118, 189, 0.18)",
              "full": false,
              "lineColor": "rgb(31, 120, 193)",
              "show": true
            },
            "tableColumn": "",
            "targets": [
              {
                "expr": "sum(kube_pod_status_phase{namespace=~\"$namespace\", phase=\"Succeeded\"})",
                "format": "time_series",
                "intervalFactor": 1,
                "refId": "A"
              }
            ],
            "thresholds": "",
            "title": "Pods Succeeded Total",
            "type": "singlestat",
            "valueFontSize": "200%",
            "valueMaps": [
              {
                "op": "=",
                "text": "N/A",
                "value": "null"
              }
            ],
            "valueName": "total"
          },
          {
            "cacheTimeout": null,
            "colorBackground": true,
            "colorValue": false,
            "colors": [
              "#d44a3a",
              "rgba(237, 129, 40, 0.89)",
              "#299c46"
            ],
            "datasource": "${DS_PROMETHEUS}",
            "format": "none",
            "gauge": {
              "maxValue": 100,
              "minValue": 0,
              "show": false,
              "thresholdLabels": false,
              "thresholdMarkers": true
            },
            "gridPos": {
              "h": 5,
              "w": 4,
              "x": 20,
              "y": 0
            },
            "id": 30,
            "interval": null,
            "links": [],
            "mappingType": 1,
            "mappingTypes": [
              {
                "name": "value to text",
                "value": 1
              },
              {
                "name": "range to text",
                "value": 2
              }
            ],
            "maxDataPoints": 100,
            "nullPointMode": "connected",
            "nullText": null,
            "postfix": "",
            "postfixFontSize": "50%",
            "prefix": "",
            "prefixFontSize": "50%",
            "rangeMaps": [
              {
                "from": "null",
                "text": "N/A",
                "to": "null"
              }
            ],
            "sparkline": {
              "fillColor": "rgba(31, 118, 189, 0.18)",
              "full": false,
              "lineColor": "rgb(31, 120, 193)",
              "show": false
            },
            "tableColumn": "",
            "targets": [
              {
                "expr": "sum(ALERTS{alertstate=\"firing\",alertname!=\"DeadMansSwitch\"})",
                "format": "time_series",
                "intervalFactor": 1,
                "refId": "A"
              }
            ],
            "thresholds": "1,2",
            "title": "DeadMansSwitch",
            "type": "singlestat",
            "valueFontSize": "200%",
            "valueMaps": [
              {
                "op": "=",
                "text": "N/A",
                "value": "null"
              }
            ],
            "valueName": "current"
          },
          {
            "cacheTimeout": null,
            "colorBackground": false,
            "colorValue": false,
            "colors": [
              "#299c46",
              "rgba(237, 129, 40, 0.89)",
              "#d44a3a"
            ],
            "datasource": "${DS_PROMETHEUS}",
            "format": "none",
            "gauge": {
              "maxValue": 100,
              "minValue": 0,
              "show": false,
              "thresholdLabels": false,
              "thresholdMarkers": true
            },
            "gridPos": {
              "h": 5,
              "w": 4,
              "x": 0,
              "y": 5
            },
            "id": 16,
            "interval": null,
            "links": [],
            "mappingType": 1,
            "mappingTypes": [
              {
                "name": "value to text",
                "value": 1
              },
              {
                "name": "range to text",
                "value": 2
              }
            ],
            "maxDataPoints": 100,
            "nullPointMode": "connected",
            "nullText": null,
            "postfix": "",
            "postfixFontSize": "50%",
            "prefix": "",
            "prefixFontSize": "50%",
            "rangeMaps": [
              {
                "from": "null",
                "text": "N/A",
                "to": "null"
              }
            ],
            "sparkline": {
              "fillColor": "rgba(31, 118, 189, 0.18)",
              "full": false,
              "lineColor": "rgb(31, 120, 193)",
              "show": true
            },
            "tableColumn": "",
            "targets": [
              {
                "expr": "sum(kube_pod_container_status_running{namespace=~\"$namespace\"})",
                "format": "time_series",
                "intervalFactor": 1,
                "refId": "A"
              }
            ],
            "thresholds": "",
            "title": "Containers Running Current",
            "type": "singlestat",
            "valueFontSize": "200%",
            "valueMaps": [
              {
                "op": "=",
                "text": "N/A",
                "value": "null"
              }
            ],
            "valueName": "current"
          },
          {
            "cacheTimeout": null,
            "colorBackground": false,
            "colorValue": false,
            "colors": [
              "#299c46",
              "rgba(237, 129, 40, 0.89)",
              "#d44a3a"
            ],
            "datasource": "${DS_PROMETHEUS}",
            "format": "none",
            "gauge": {
              "maxValue": 100,
              "minValue": 0,
              "show": false,
              "thresholdLabels": false,
              "thresholdMarkers": true
            },
            "gridPos": {
              "h": 5,
              "w": 4,
              "x": 4,
              "y": 5
            },
            "id": 18,
            "interval": null,
            "links": [],
            "mappingType": 1,
            "mappingTypes": [
              {
                "name": "value to text",
                "value": 1
              },
              {
                "name": "range to text",
                "value": 2
              }
            ],
            "maxDataPoints": 100,
            "nullPointMode": "connected",
            "nullText": null,
            "postfix": "",
            "postfixFontSize": "50%",
            "prefix": "",
            "prefixFontSize": "50%",
            "rangeMaps": [
              {
                "from": "null",
                "text": "N/A",
                "to": "null"
              }
            ],
            "sparkline": {
              "fillColor": "rgba(31, 118, 189, 0.18)",
              "full": false,
              "lineColor": "rgb(31, 120, 193)",
              "show": true
            },
            "tableColumn": "",
            "targets": [
              {
                "expr": "sum(kube_pod_container_status_waiting{namespace=~\"$namespace\"})",
                "format": "time_series",
                "intervalFactor": 1,
                "refId": "A"
              }
            ],
            "thresholds": "",
            "title": "Containers Waiting Total",
            "type": "singlestat",
            "valueFontSize": "200%",
            "valueMaps": [
              {
                "op": "=",
                "text": "N/A",
                "value": "null"
              }
            ],
            "valueName": "total"
          },
          {
            "cacheTimeout": null,
            "colorBackground": false,
            "colorValue": false,
            "colors": [
              "#299c46",
              "rgba(237, 129, 40, 0.89)",
              "#d44a3a"
            ],
            "datasource": "${DS_PROMETHEUS}",
            "format": "none",
            "gauge": {
              "maxValue": 100,
              "minValue": 0,
              "show": false,
              "thresholdLabels": false,
              "thresholdMarkers": true
            },
            "gridPos": {
              "h": 5,
              "w": 4,
              "x": 8,
              "y": 5
            },
            "id": 2,
            "interval": null,
            "links": [],
            "mappingType": 1,
            "mappingTypes": [
              {
                "name": "value to text",
                "value": 1
              },
              {
                "name": "range to text",
                "value": 2
              }
            ],
            "maxDataPoints": 100,
            "nullPointMode": "connected",
            "nullText": null,
            "postfix": "",
            "postfixFontSize": "50%",
            "prefix": "",
            "prefixFontSize": "50%",
            "rangeMaps": [
              {
                "from": "null",
                "text": "N/A",
                "to": "null"
              }
            ],
            "sparkline": {
              "fillColor": "rgba(31, 118, 189, 0.18)",
              "full": false,
              "lineColor": "rgb(31, 120, 193)",
              "show": true
            },
            "tableColumn": "",
            "targets": [
              {
                "expr": "sum(delta(kube_pod_container_status_restarts{namespace=\"$namespace\"}[30m]))",
                "format": "time_series",
                "interval": "",
                "intervalFactor": 1,
                "refId": "A"
              }
            ],
            "thresholds": "",
            "title": "Containers Restarts Total",
            "type": "singlestat",
            "valueFontSize": "200%",
            "valueMaps": [
              {
                "op": "=",
                "text": "N/A",
                "value": "null"
              }
            ],
            "valueName": "total"
          },
          {
            "cacheTimeout": null,
            "colorBackground": false,
            "colorValue": false,
            "colors": [
              "#299c46",
              "rgba(237, 129, 40, 0.89)",
              "#d44a3a"
            ],
            "datasource": "${DS_PROMETHEUS}",
            "format": "none",
            "gauge": {
              "maxValue": 100,
              "minValue": 0,
              "show": false,
              "thresholdLabels": false,
              "thresholdMarkers": true
            },
            "gridPos": {
              "h": 5,
              "w": 4,
              "x": 12,
              "y": 5
            },
            "id": 20,
            "interval": null,
            "links": [],
            "mappingType": 1,
            "mappingTypes": [
              {
                "name": "value to text",
                "value": 1
              },
              {
                "name": "range to text",
                "value": 2
              }
            ],
            "maxDataPoints": 100,
            "nullPointMode": "connected",
            "nullText": null,
            "postfix": "",
            "postfixFontSize": "50%",
            "prefix": "",
            "prefixFontSize": "50%",
            "rangeMaps": [
              {
                "from": "null",
                "text": "N/A",
                "to": "null"
              }
            ],
            "sparkline": {
              "fillColor": "rgba(31, 118, 189, 0.18)",
              "full": false,
              "lineColor": "rgb(31, 120, 193)",
              "show": true
            },
            "tableColumn": "",
            "targets": [
              {
                "expr": "sum(kube_pod_container_status_terminated{namespace=~\"$namespace\"})",
                "format": "time_series",
                "intervalFactor": 1,
                "refId": "A"
              }
            ],
            "thresholds": "",
            "title": "Containers Terminated Total",
            "type": "singlestat",
            "valueFontSize": "200%",
            "valueMaps": [
              {
                "op": "=",
                "text": "N/A",
                "value": "null"
              }
            ],
            "valueName": "total"
          },
          {
            "cacheTimeout": null,
            "colorBackground": false,
            "colorValue": false,
            "colors": [
              "#299c46",
              "rgba(237, 129, 40, 0.89)",
              "#d44a3a"
            ],
            "datasource": "${DS_PROMETHEUS}",
            "format": "none",
            "gauge": {
              "maxValue": 100,
              "minValue": 0,
              "show": false,
              "thresholdLabels": false,
              "thresholdMarkers": true
            },
            "gridPos": {
              "h": 5,
              "w": 4,
              "x": 16,
              "y": 5
            },
            "id": 22,
            "interval": null,
            "links": [],
            "mappingType": 1,
            "mappingTypes": [
              {
                "name": "value to text",
                "value": 1
              },
              {
                "name": "range to text",
                "value": 2
              }
            ],
            "maxDataPoints": 100,
            "nullPointMode": "connected",
            "nullText": null,
            "postfix": "",
            "postfixFontSize": "50%",
            "prefix": "",
            "prefixFontSize": "50%",
            "rangeMaps": [
              {
                "from": "null",
                "text": "N/A",
                "to": "null"
              }
            ],
            "sparkline": {
              "fillColor": "rgba(31, 118, 189, 0.18)",
              "full": false,
              "lineColor": "rgb(31, 120, 193)",
              "show": true
            },
            "tableColumn": "",
            "targets": [
              {
                "expr": "sum(kube_pod_container_resource_requests_cpu_cores{namespace=~\"$namespace\", node=~\"$node\"})",
                "format": "time_series",
                "intervalFactor": 1,
                "refId": "A"
              }
            ],
            "thresholds": "",
            "title": "CPU Cores Req by Containers Current",
            "type": "singlestat",
            "valueFontSize": "200%",
            "valueMaps": [
              {
                "op": "=",
                "text": "N/A",
                "value": "null"
              }
            ],
            "valueName": "current"
          },
          {
            "cacheTimeout": null,
            "colorBackground": false,
            "colorValue": true,
            "colors": [
              "rgba(50, 172, 45, 0.97)",
              "rgba(237, 129, 40, 0.89)",
              "rgba(245, 54, 54, 0.9)"
            ],
            "datasource": "${DS_PROMETHEUS}",
            "decimals": 2,
            "format": "percent",
            "gauge": {
              "maxValue": 100,
              "minValue": 0,
              "show": true,
              "thresholdLabels": false,
              "thresholdMarkers": true
            },
            "gridPos": {
              "h": 5,
              "w": 4,
              "x": 20,
              "y": 5
            },
            "id": 32,
            "interval": null,
            "links": [],
            "mappingType": 1,
            "mappingTypes": [
              {
                "name": "value to text",
                "value": 1
              },
              {
                "name": "range to text",
                "value": 2
              }
            ],
            "maxDataPoints": 100,
            "nullPointMode": "connected",
            "nullText": null,
            "postfix": "",
            "postfixFontSize": "50%",
            "prefix": "",
            "prefixFontSize": "50%",
            "rangeMaps": [
              {
                "from": "null",
                "text": "N/A",
                "to": "null"
              }
            ],
            "sparkline": {
              "fillColor": "rgba(31, 118, 189, 0.18)",
              "full": false,
              "lineColor": "rgb(31, 120, 193)",
              "show": false
            },
            "tableColumn": "",
            "targets": [
              {
                "expr": "sum (rate (container_cpu_usage_seconds_total{image!=\"\",name=~\"^k8s_.*\"}[5m])) / sum (machine_cpu_cores) * 100",
                "format": "time_series",
                "hide": false,
                "intervalFactor": 2,
                "refId": "A",
                "step": 60
              }
            ],
            "thresholds": "60,80",
            "title": "Cluster CPU usage Current",
            "type": "singlestat",
            "valueFontSize": "80%",
            "valueMaps": [
              {
                "op": "=",
                "text": "N/A",
                "value": "null"
              }
            ],
            "valueName": "current"
          },
          {
            "columns": [],
            "datasource": "${DS_PROMETHEUS}",
            "description": "The nodes of the cluster",
            "fontSize": "100%",
            "gridPos": {
              "h": 5,
              "w": 8,
              "x": 0,
              "y": 10
            },
            "id": 28,
            "links": [],
            "pageSize": null,
            "scroll": true,
            "showHeader": true,
            "sort": {
              "col": 0,
              "desc": true
            },
            "styles": [
              {
                "alias": "Time",
                "dateFormat": "YYYY-MM-DD HH:mm:ss",
                "pattern": "Time",
                "type": "hidden"
              },
              {
                "alias": "",
                "colorMode": null,
                "colors": [
                  "rgba(245, 54, 54, 0.9)",
                  "rgba(237, 129, 40, 0.89)",
                  "rgba(50, 172, 45, 0.97)"
                ],
                "dateFormat": "YYYY-MM-DD HH:mm:ss",
                "decimals": 2,
                "mappingType": 1,
                "pattern": "/Value/",
                "thresholds": [],
                "type": "hidden",
                "unit": "short"
              },
              {
                "alias": "",
                "colorMode": null,
                "colors": [
                  "rgba(245, 54, 54, 0.9)",
                  "rgba(237, 129, 40, 0.89)",
                  "rgba(50, 172, 45, 0.97)"
                ],
                "decimals": 0,
                "pattern": "/.*/",
                "thresholds": [],
                "type": "number",
                "unit": "short"
              }
            ],
            "targets": [
              {
                "expr": "sum(kube_node_info) by (node, kubelet_version)",
                "format": "table",
                "instant": true,
                "intervalFactor": 1,
                "refId": "A"
              }
            ],
            "title": "Nodes",
            "transform": "table",
            "type": "table"
          },
          {
            "cacheTimeout": null,
            "colorBackground": false,
            "colorValue": false,
            "colors": [
              "#299c46",
              "rgba(237, 129, 40, 0.89)",
              "#d44a3a"
            ],
            "datasource": "${DS_PROMETHEUS}",
            "format": "none",
            "gauge": {
              "maxValue": 100,
              "minValue": 0,
              "show": false,
              "thresholdLabels": false,
              "thresholdMarkers": true
            },
            "gridPos": {
              "h": 5,
              "w": 8,
              "x": 8,
              "y": 10
            },
            "id": 26,
            "interval": null,
            "links": [],
            "mappingType": 1,
            "mappingTypes": [
              {
                "name": "value to text",
                "value": 1
              },
              {
                "name": "range to text",
                "value": 2
              }
            ],
            "maxDataPoints": 100,
            "nullPointMode": "connected",
            "nullText": null,
            "postfix": "",
            "postfixFontSize": "50%",
            "prefix": "",
            "prefixFontSize": "50%",
            "rangeMaps": [
              {
                "from": "null",
                "text": "N/A",
                "to": "null"
              }
            ],
            "sparkline": {
              "fillColor": "rgba(31, 118, 189, 0.18)",
              "full": false,
              "lineColor": "rgb(31, 120, 193)",
              "show": true
            },
            "tableColumn": "Value",
            "targets": [
              {
                "expr": "count(kube_node_info)",
                "format": "table",
                "intervalFactor": 1,
                "refId": "A"
              }
            ],
            "thresholds": "",
            "title": "Number of Nodes",
            "type": "singlestat",
            "valueFontSize": "200%",
            "valueMaps": [
              {
                "op": "=",
                "text": "N/A",
                "value": "null"
              }
            ],
            "valueName": "avg"
          },
          {
            "cacheTimeout": null,
            "colorBackground": false,
            "colorValue": false,
            "colors": [
              "#299c46",
              "rgba(237, 129, 40, 0.89)",
              "#d44a3a"
            ],
            "datasource": "${DS_PROMETHEUS}",
            "format": "decbytes",
            "gauge": {
              "maxValue": 100,
              "minValue": 0,
              "show": false,
              "thresholdLabels": false,
              "thresholdMarkers": true
            },
            "gridPos": {
              "h": 5,
              "w": 4,
              "x": 16,
              "y": 10
            },
            "id": 24,
            "interval": null,
            "links": [],
            "mappingType": 1,
            "mappingTypes": [
              {
                "name": "value to text",
                "value": 1
              },
              {
                "name": "range to text",
                "value": 2
              }
            ],
            "maxDataPoints": 100,
            "nullPointMode": "connected",
            "nullText": null,
            "postfix": "",
            "postfixFontSize": "50%",
            "prefix": "",
            "prefixFontSize": "50%",
            "rangeMaps": [
              {
                "from": "null",
                "text": "N/A",
                "to": "null"
              }
            ],
            "sparkline": {
              "fillColor": "rgba(31, 118, 189, 0.18)",
              "full": false,
              "lineColor": "rgb(31, 120, 193)",
              "show": false
            },
            "tableColumn": "",
            "targets": [
              {
                "expr": "sum(kube_pod_container_resource_requests_memory_bytes{namespace=~\"$namespace\", node=~\"$node\"})",
                "format": "time_series",
                "intervalFactor": 1,
                "refId": "A"
              }
            ],
            "thresholds": "",
            "title": "Memory Requested By Containers Current",
            "type": "singlestat",
            "valueFontSize": "170%",
            "valueMaps": [
              {
                "op": "=",
                "text": "N/A",
                "value": "null"
              }
            ],
            "valueName": "current"
          },
          {
            "cacheTimeout": null,
            "colorBackground": false,
            "colorValue": true,
            "colors": [
              "rgba(50, 172, 45, 0.97)",
              "rgba(237, 129, 40, 0.89)",
              "rgba(245, 54, 54, 0.9)"
            ],
            "datasource": "${DS_PROMETHEUS}",
            "decimals": 2,
            "format": "percent",
            "gauge": {
              "maxValue": 100,
              "minValue": 0,
              "show": true,
              "thresholdLabels": false,
              "thresholdMarkers": true
            },
            "gridPos": {
              "h": 5,
              "w": 4,
              "x": 20,
              "y": 10
            },
            "id": 33,
            "interval": null,
            "links": [],
            "mappingType": 1,
            "mappingTypes": [
              {
                "name": "value to text",
                "value": 1
              },
              {
                "name": "range to text",
                "value": 2
              }
            ],
            "maxDataPoints": 100,
            "nullPointMode": "connected",
            "nullText": null,
            "postfix": "",
            "postfixFontSize": "50%",
            "prefix": "",
            "prefixFontSize": "50%",
            "rangeMaps": [
              {
                "from": "null",
                "text": "N/A",
                "to": "null"
              }
            ],
            "sparkline": {
              "fillColor": "rgba(31, 118, 189, 0.18)",
              "full": false,
              "lineColor": "rgb(31, 120, 193)",
              "show": false
            },
            "tableColumn": "",
            "targets": [
              {
                "expr": "sum(container_memory_working_set_bytes{image!=\"\",name=~\"^k8s_.*\"}) / sum (machine_memory_bytes) * 100",
                "format": "time_series",
                "intervalFactor": 2,
                "refId": "A",
                "step": 60
              }
            ],
            "thresholds": "60,80",
            "title": "Cluster Memory usage Current",
            "type": "singlestat",
            "valueFontSize": "80%",
            "valueMaps": [
              {
                "op": "=",
                "text": "N/A",
                "value": "null"
              }
            ],
            "valueName": "current"
          },
          {
            "aliasColors": {},
            "bars": false,
            "dashLength": 10,
            "dashes": false,
            "datasource": "${DS_PROMETHEUS}",
            "fill": 1,
            "gridPos": {
              "h": 6,
              "w": 24,
              "x": 0,
              "y": 15
            },
            "id": 35,
            "legend": {
              "avg": false,
              "current": false,
              "max": false,
              "min": false,
              "show": true,
              "total": false,
              "values": false
            },
            "lines": true,
            "linewidth": 1,
            "links": [],
            "nullPointMode": "null",
            "percentage": false,
            "pointradius": 5,
            "points": false,
            "renderer": "flot",
            "seriesOverrides": [],
            "spaceLength": 10,
            "stack": false,
            "steppedLine": false,
            "targets": [
              {
                "expr": "100 * sum by(instance, job) (rate(rest_client_requests_total{code!~\"2..\"}[5m]))/ sum by(instance, job) (rate(rest_client_requests_total[5m]))",
                "format": "time_series",
                "intervalFactor": 1,
                "refId": "A"
              }
            ],
            "thresholds": [],
            "timeFrom": null,
            "timeShift": null,
            "title": "Failed Rest Client Request from KubeCTL",
            "tooltip": {
              "shared": true,
              "sort": 0,
              "value_type": "individual"
            },
            "transparent": false,
            "type": "graph",
            "xaxis": {
              "buckets": null,
              "mode": "time",
              "name": null,
              "show": true,
              "values": []
            },
            "yaxes": [
              {
                "format": "short",
                "label": null,
                "logBase": 1,
                "max": null,
                "min": null,
                "show": true
              },
              {
                "format": "short",
                "label": null,
                "logBase": 1,
                "max": null,
                "min": null,
                "show": true
              }
            ]
          }
        ],
        "refresh": "1m",
        "schemaVersion": 16,
        "style": "dark",
        "tags": [],
        "templating": {
          "list": [
            {
              "current": {
                "text": "No data sources found",
                "value": ""
              },
              "hide": 2,
              "label": null,
              "name": "datasource",
              "options": [],
              "query": "",
              "refresh": 1,
              "regex": "/$ds/",
              "type": "datasource"
            },
            {
              "current": {
                "value": "${VAR_NODE}",
                "text": "${VAR_NODE}"
              },
              "hide": 0,
              "label": null,
              "name": "node",
              "options": [
                {
                  "value": "${VAR_NODE}",
                  "text": "${VAR_NODE}"
                }
              ],
              "query": "${VAR_NODE}",
              "type": "constant"
            },
            {
              "current": {
                "value": "${VAR_NAMESPACE}",
                "text": "${VAR_NAMESPACE}"
              },
              "hide": 0,
              "label": null,
              "name": "namespace",
              "options": [
                {
                  "value": "${VAR_NAMESPACE}",
                  "text": "${VAR_NAMESPACE}"
                }
              ],
              "query": "${VAR_NAMESPACE}",
              "type": "constant"
            }
          ]
        },
        "time": {
          "from": "now-5m",
          "to": "now"
        },
        "timepicker": {
          "refresh_intervals": [
            "5s",
            "10s",
            "30s",
            "1m",
            "5m",
            "15m",
            "30m",
            "1h",
            "2h",
            "1d"
          ],
          "time_options": [
            "5m",
            "15m",
            "1h",
            "6h",
            "12h",
            "24h",
            "2d",
            "7d",
            "30d"
          ]
        },
        "timezone": "",
        "title": "RPI 1",
        "version": 1
      },
      "inputs": [
        {
          "name": "DS_PROMETHEUS",
          "label": "prometheus",
          "description": "",
          "type": "datasource",
          "pluginId": "prometheus",
          "pluginName": "Prometheus",
          "value": "prometheus"
        },
        {
          "name": "VAR_NODE",
          "type": "constant",
          "label": "node",
          "value": ".*",
          "description": ""
        },
        {
          "name": "VAR_NAMESPACE",
          "type": "constant",
          "label": "namespace",
          "value": ".*",
          "description": ""
        }
      ],
      "overwrite": true
    }
```
 

##### To update current configmap use below command.

`kubectl replace -f custom-dashboards.yaml -n monitoring`

 
##### Install Prometheus Operator

`helm install coreos/prometheus-operator --name prometheus-operator --namespace monitoring`

##### Install Prometheus and Grafana

`helm install coreos/kube-prometheus --name kube-prometheus -f values.yaml --namespace monitoring`

##### In values add below:

```
## A list of additional configmaps that contain -dashboard.json and/or -datasource.json files
## that should be imported into grafana.
  serverDashboardConfigmaps:
    - custom-dashboards
```

##### Upgrade Prometheus and Grafana

`helm upgrade --install kube-prometheus -f values.yaml --namespace monitoring coreos/kube-prometheus`


###### Converting Grafana dashboard format to ConfigMap format.

```
# !/bin/bash
# 
# Usage: 
# 1. Copy the JSON from Grafana -> Export as JSON -> Clipboard -> Save as json
# 2. ./prepare_dashboard.sh saved_json.json
# - This will update saved_json.json
#
# This script is based on one of @aranair:
# https://gist.github.com/aranair/bec788df5a9a292f42e088e481b856c6

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ "$#" -ne 1 ]; then
  echo "Usage: ./prepare_dashboard.sh <name_of_dashboard>"
  exit
fi

# Prepare JSON for Grafana Watcher
newContent=`cat "$DIR/$1" | \
  jq 'select(has("dashboard") | not) | .id = null | del(.__requires) | del(.uid) | { dashboard: . , inputs: .__inputs, overwrite: true  }' | \
  jq '.inputs[0].value=.inputs[0].pluginId'`

# If above commands find "dashboard" at the object root it will avoid doing anything
if [ "$newContent" != "" ]
then
  echo "$newContent" > "$DIR/$1"
  echo "The file is ready to be imported in Grafana"
else
  echo "This file has already been modified"
fi
```

 

 

 

 

 

