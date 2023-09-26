## Job <a name="job"> </a>

- Run repeated tasks till the completion
- Is controller which supervise Pod to accomplish certain task

### Types

- Run to completion (Jobs)
  - Perform bash processing
  - Controller will wait for return code exit 0 to shut down job
  - Must be deleted manually
- Scheduler (CronJob)
  - Similar to cron job in linux
  - Main purpose free space, dump logs,... repeatedly
