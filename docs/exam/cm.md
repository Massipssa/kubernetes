apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: nginx
  name: nginx
spec:
  containers:
  - image: nginx
    name: nginx
    env:
    # load by key
    - name: MY_CONFIG_KEY
      valueFrom:
        configMapKeyRef:
          name: options
          key: var3
    # load all cm 
    envFrom:
    - configMapRef:
       name: anotherone
    # mount the cm as volume
    volumeMounts:
    - name: myvolume
      mountPath: test/path
  restartPolicy: Always
  volumes: 
  # create config map as volume
  - name: myvolume
    configMap:
     name: cmvolume
