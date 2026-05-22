# Home Lab Metrics Collector v1.0

import psutil
import socket
import time
from prometheus_client import start_http_server, Gauge

hostname = socket.gethostname()

# Define metrics
cpu_gauge = Gauge('node_cpu_percent', 'CPU usage percent', ['host'])
memory_gauge = Gauge('node_memory_percent', 'Memory usage percent', ['host'])
disk_gauge = Gauge('node_disk_percent', 'Disk usage percent', ['host'])

def collect_metrics():
    cpu_gauge.labels(host=hostname).set(psutil.cpu_percent(interval=1))
    memory_gauge.labels(host=hostname).set(psutil.virtual_memory().percent)
    disk_gauge.labels(host=hostname).set(psutil.disk_usage('/').percent)

if __name__ == '__main__':
    start_http_server(8000)
    print(f"[{hostname}] Metrics server started on port 8000")
    while True:
        collect_metrics()
        time.sleep(10)