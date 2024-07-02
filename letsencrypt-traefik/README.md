# LetsEncrypt Traefik

The Previder Portal API is fully PowerDNS v1 compatible, so any PowerDNS client should work.

The same settings may apply to ingresses like Caddy, but these are not tested yet.

## Server settings

### Server ID
The default server ID of PowerDNS and clients is `localhost`, this has to be overridden with the name `previder`.
`/api/v1/servers/previder/zones` will show all the zones available to the token.

### API Version
It's possible you have to provide the API version if the client wants to do a version discover, we do not support the config endpoint.

The base URL should always be `/api/v1` (PowerDNS base URL) or `/api/v2/drs/domain/dns` (Previder Portal PowerDNS compatible API).  
`/api/v1/servers` is linked to `/api/v2/drs/domain/dns/servers`. Any endpoint above this call will not give a PowerDNS response.

### Authentication
A Previder Portal [user](https://portal.previder.nl/#/user/current/tokens) or [application](https://portal.previder.nl/#/application) token is required to alter DNS and request domains.  
The privileges need to be Read on Domains and Read/Update on DNS for a client. This token will be visible to anyone who has access to the deployment, make a role with the right privileges to work secure by default.

## Traefik
This example uses [Docker Compose](https://docs.docker.com/compose/) to start a Traefik instance.

### Deployment
Create a docker-compose.yml with the following content. 

```yaml
services:
  reverse-proxy:
    image: traefik:latest # never use latest tag in production
    restart: always
    command: --api.insecure=true --providers.docker
    ports:
      - "80:80"
      - "8080:8080"
      - "443:443"
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - /data/docker/traefik/traefik.yml:/etc/traefik/traefik.yml # Alter the path to your instance
      - /data/docker/traefik/acme.json:/tmp/acme.json # Alter the path to your instance
    environment:
      - PDNS_API_URL=https://portal.previder.com 
      - PDNS_API_KEY=<token> # Alter this value to your token
      - PDNS_SERVER_NAME=previder # Server name previder to overrule localhost
      - PDNS_API_VERSION=1 # We provide the API version here so the client will not try to auto-discover one
```

### Config
Traefik itself needs a configuration to know the new certificateResolver called `previderResolver`.

```yaml
log:
  level: debug # Change to info after configuration is successful

entryPoints:
  http:
    address: ":80"
  https:
    address: ":443"
  traefik:
    address: ":8080"

api:
  insecure: true
  dashboard: true

providers:
  docker:
    endpoint: "unix:///var/run/docker.sock"
    exposedByDefault: false
    watch: true

certificatesResolvers:
  previderResolver:
    acme:
      # Staging letsEncrypt API CA server
      caServer: https://acme-staging-v02.api.letsencrypt.org/directory # Disable this line after testing succeeds to not get blocklisted by the production Letsencrypt API
      email: <your-email> # Change this to your account email address
      storage: /tmp/acme.json
      dnsChallenge:
        provider: pdns
        resolvers: 
        - 80.65.96.50:53 # Resolve at Previder, will not work outside Previder network
        - 62.165.127.222 # Resolve at Previder 2, will not work outside Previder network
        - 8.8.8.8:53 # Resolve at Google as fallback
        - 9.9.9.9:53 # Resolve at Quad nine as fallback
```

### Starting the application
use the command `docker compose up -d` to start Traefik.  
Check the logs if everything started correctly. `docker compose logs -f`  
Run the logs of Traefik in a seperate terminal to catch any errors.

## Application deployment
When Traefik is running with the Previder DNS resolver, you can create an application which uses this resolver.

This is an example docker compose to get a SSL certificate for the subdomain whoami. (Always use a valid domain which exists and resolves in the Previder Portal to prevent blocklisting)

```yaml
services:
  whoami:
    image: "traefik/whoami"
    container_name: "whoami-example"
    ports:
      8443:80
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.whoami.rule=Host(`whoami.domain`)"
      - "traefik.http.routers.whoami.tls=true"
      - "traefik.http.routers.whoami.tls.certresolver=previderResolver"
      - "traefik.http.routers.whoami.entrypoints=https"
```

After the `docker compose up -d` of this file, the logging of Traefik will show entries like below:

```text
Looking for provided certificate(s) to validate ["whoami.domain"]... ACME CA=https://acme-v02.api.letsencrypt.org/directory acmeCA=https://acme-v02.api.letsencrypt.org/directory providerName=previderResolver.acme routerName=whoami@docker rule=Host(`whoami.domain`)
```
```text
Domains need ACME certificates generation for domains "whoami.domain"
```
```text
[INFO] [whoami.domain] acme: Obtaining bundled SAN certificate lib=lego
[INFO] [whoami.domain] AuthURL: https://acme-v02.api.letsencrypt.org/acme/ lib=lego
[INFO] [whoami.domain] acme: Could not find solver for: tls-alpn-01 lib=lego
[INFO] [whoami.domain] acme: Could not find solver for: http-01 lib=lego
[INFO] [whoami.domain] acme: use dns-01 solver lib=lego
[INFO] [whoami.domain] acme: Preparing to solve DNS-01 lib=lego
[INFO] [whoami.domain] acme: Trying to solve DNS-01 lib=lego
[INFO] [whoami.domain] acme: Checking DNS record propagation. [nameservers=8.8.8.8:53] lib=lego
[INFO] Wait for propagation [timeout: 2m0s, interval: 2s] lib=lego
[INFO] [whoami.domain] acme: Waiting for DNS record propagation. lib=lego
[INFO] [whoami.domain] acme: Waiting for DNS record propagation. lib=lego
[INFO] [whoami.domain] acme: Waiting for DNS record propagation. lib=lego
[INFO] [whoami.domain] acme: Waiting for DNS record propagation. lib=lego
```
And eventually the success line. This can take a minute or 2.
```text
Certificates obtained for domains [whoami.domain] 
```

After this, the certificate should be active and your `whoami` instance should be reachable on the `whoami.domain` subdomain.

