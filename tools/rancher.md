1. Launch docker container
   ```
    docker run -d --restart=unless-stopped \
        -p 80:80 -p 443:443 \
        --name rancher \
        -v /opt/rancher:/var/lib/rancher rancher/rancher
   ```