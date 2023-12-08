./bin/spark-submit \
    --master k8s://https://10.0.2.15:8443 \
    --deploy-mode cluster \
    --name spark-pi \
    --class org.apache.spark.examples.SparkPi \
    --conf spark.executor.instances=3 \
    --conf spark.kubernetes.container.image=spark:latest \
    local:///opt/spark/examples/jars/spark-examples_2.12-3.0.0.jar