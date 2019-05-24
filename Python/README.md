#### Simple Python GET request and display results.

```
import requests
r = requests.get('https://google.com')
print(r.url)
print(r.status_code)
print(r.text)
```

#### Push request to postman-echo and display results.

```
import requests

URL = 'https://postman-echo.com/basic-auth'
USER = ('postman')
PASSWORD = ('password')
parameters = {'test': 'true'}

auth = (USER, PASSWORD)

r = requests.get(URL, auth=auth, json=parameters)


print(r.url)
print(r.status_code)
print(r.text)
```

#### Configure MongoDB via API key. Update GROUP ID, CLUSTER ID, USERNAME, API KEY. 
Uncomment parameters as this will unpause the cluster.

```
import requests
from requests.auth import HTTPDigestAuth

URL = 'https://cloud.mongodb.com/api/atlas/v1.0/groups/GROUP_ID/clusters/CLUSTER_ID'
USER = ('user@domain.com')
PASSWORD = ('API_KEY')
#parameters = {'paused': 'false'}

auth = HTTPDigestAuth(USER, PASSWORD)

r = requests.patch(URL, auth=auth, json=parameters)

print(r.url)
print(r.status_code)
print(r.text)
```





















