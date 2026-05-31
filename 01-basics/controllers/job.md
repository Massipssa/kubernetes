# Jobs and CronJobs

Jobs run finite work until completion. CronJobs create Jobs on a schedule.

## Job

Use a Job for work that should finish successfully:

- Data migrations.
- Batch processing.
- One-time scripts.
- Backup or export tasks.

The Job controller creates Pods and watches for a successful exit code. Completed Jobs stay in the cluster until you delete them or configure cleanup.

## CronJob

Use a CronJob for repeated work:

- Scheduled backups.
- Periodic cleanup.
- Report generation.
- Log rotation.

## Commands

```bash
kubectl apply -f controllers/examples/job.yml
kubectl get jobs -n dev
kubectl logs job/count-to-six -n dev
kubectl delete -f controllers/examples/job.yml

kubectl apply -f controllers/examples/cronJob.yml
kubectl get cronjobs -n dev
kubectl delete -f controllers/examples/cronJob.yml
```
