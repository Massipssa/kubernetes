# Service Discovery 

Discover and access the devices and the services automatically. 

- Two patterns 
  - Client-Side: the client by itself should implement query logic to discover the service.
  - Server-Side:  the request goes to a load balancer (server) and the load balancer connects to the service registry 
    to get the IP addresses of the healthy backend servers.

## CoreDNS