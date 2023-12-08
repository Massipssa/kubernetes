## Basic commands

### Objects

- **Create**

    ```kubectl create -f /path/to/rc.yml```

- **Describe, delete, get ...**

    ```kubectl <command> rc [rc-name]```

- **Get all**

    ```kubectl get po -l app=[rc-name]```
    ```kubectl get pod -o [format]```

- **Scale up and down**
    
    ```kubectl scale rc <rc-name> --replicas=[new-number]  ```


- execute pod: `kubectl exec -it <pod-name> <command>`
- check auth: `kubectl auth can-i <list | create | edit | delete> <object>`