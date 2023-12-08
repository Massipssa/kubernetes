## POD

- Scheduling unit in k8S
- Provides runtime environment for application that we deploy

- **Pod lifecycle**
  1. Submit file (yaml or json) to API Server
  2. Pods go to scheduler, and they stay in **Pending** state until all scheduled they pass to **Running**
  3. Pod may have:
     - **Succeed**
     - **Failed**: when Pod fails it cannot be recovered

- **Create**
    ```kubectl  create -f path/to/file.yml```

- **Get**
    ```kubectl  get pod```

- **Describe, delete, get**
    ```kubectl  <command>  pod [pod-name]```

## Multi-container Pod 

- They are Pods that include multiple containers that work together
- Patterns: 
  - **Sidecar:** performs a task to assist the main container
  - **Ambassador:** proxies network traffic to and/or from the main container  
  - **Adapter:** transforms the main container's output in some way

- When should use multi-container
 - Only use multi-container Pods when the containers need to be tightly coupled, sharing resources such as network 
   and storage volumes

## Init Container

- Is a container that runs to complete a task before a Pod's main container starts up
- When to use
  - Separate image: can use separate image to perform stat-up tasks using software that the main image does not include
    or need  
  - Delay startup: can be used to delay startup of main container until certain preconditions are met 
  - Security: can perform sensitive stat-up, like consuming secrets in isolation from the main container 

